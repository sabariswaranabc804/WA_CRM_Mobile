# Bulk Chat Mobile: Update Plan

This plan brings the Flutter app (`wacrm-mobile`) in line with the current server (`server/src/api/v1`) and web client (`client/src`).

**In scope:** Chats, Contacts, Segments (new), Campaigns, Templates, Settings.
**Out of scope:** CRM, automations, flows, calling, commerce, billing, developer, admin.

All paths are relative to the base URL `.../api/v1`. Each work item names the file to change.

---

## 0. What changed since the mobile app was written

| Area | Old mobile assumption | Server today | Action |
|---|---|---|---|
| Realtime | "Server has no realtime channel", so the app polls every 10 or 15 s | SSE stream at `GET /realtime/stream` (not socket.io) | Add an SSE client (section 2). Keep polling as a fallback. |
| Start chat | "There is no `POST /conversations`" | `POST /conversations/start` sends a template and opens the chat | New Chat can now start a conversation (section 3.6). |
| Conversation status | open / pending / closed | `open`, `pending`, `resolved`, `closed`, changed with `PATCH /conversations/:id/status` | Add `resolved`. Add a status picker. |
| Inbox filters | status + search | Also `assignment=unassigned\|mine`, `team_id`, `tag_id`, plus `GET /conversations/counts` | Add Mine / Unassigned tabs with counts. |
| Thread | Messages only | `GET /conversations/:id/thread` returns messages and internal notes together | Switch the thread to `/thread`. |
| Notes, tags, assign | Not supported | Endpoints exist for all three | Add them (section 3). |
| Media | Text and template only | `POST /reply` accepts multipart `file`. Media is downloaded via `GET /conversations/messages/:id/media` | Add attachments and media rendering. |
| Template params | Body `{{n}}` only | `template_body_values` + `template_params` (header text/media, URL button suffix, coupon code) | Support them in the template picker and the campaign wizard. |
| Segments | Lists are read only, inside the campaign picker | `POST /contacts/lists` (static or dynamic), `GET /contacts/lists/:id/preview`, `DELETE /contacts/lists/:id` | New Segments screen (section 5). |
| Field security | Not handled | Phone and email may come back masked. The server rejects masked values on write | Never send a masked value back (section 4.4). |

### Auth and transport (keep as is, with one risk)
- Keep sending `Authorization: Bearer <accessToken>`. Do not send cookies, which means no CSRF header is needed.
- There is no tenant, workspace or org header. The tenant is taken from the JWT.
- `POST /auth/refresh` with body `{ refreshToken }` rotates the token. The current `api_client.dart` already does this correctly.
- **Risk:** refresh returns 401 "Session validation failed" when the IP + user-agent fingerprint changes (`core/auth/use-cases/refresh-token.use-case.js`). Phones switch between Wi-Fi and mobile data all the time, so this may log users out often. **Confirm with the backend team before release.** It may need relaxing for mobile clients.
- Login can return `{ requiresPasswordChange: true }` for invited users. The login screen then has to ask for a new password and call login again with `newPassword` (section 7.1).

### Error handling (no change needed)
- Error shape: `{ success:false, error:{ code, message, details? } }`.
- Codes the UI should handle specially:
  - `ASSIGNMENT_CONFLICT` (409)
  - `VALIDATION_ERROR` (400/422; `details` holds the zod issues)
  - `TOO_MANY_ATTEMPTS` (429, with a `Retry-After` header)
- Extend `ApiException` with a `code` field read from `body.error.code`.

---

## 1. Shared foundation work (do first)

| # | Task | File(s) |
|---|---|---|
| 1.1 | Add `code` and `details` to `ApiException` | `lib/core/api_client.dart` |
| 1.2 | Add a multipart upload helper `postMultipart(path, fields, file)` that uses Dio `FormData` | `lib/core/api_client.dart` |
| 1.3 | Add a helper that downloads authenticated media (a GET with the Bearer header, cached to a temp file) for images, audio and documents | `lib/core/media_cache.dart` (new) |
| 1.4 | Add a permission helper `can(perm)` / `canAny([...])`, with an admin / super_admin bypass, matching web `RoleGuard` | `lib/state/auth_state.dart` |
| 1.5 | Add the SSE realtime service (section 2) | `lib/services/realtime_service.dart` (new) |
| 1.6 | Bump the version shown in Settings → About, and read it from `package_info_plus` | `pubspec.yaml`, settings screen |

Suggested new packages:
- `file_picker` or `image_picker` for attachments
- `record` for voice notes (optional)
- `package_info_plus`
- `open_filex` for opening documents

### Permission codes used by these modules
These come from `server/src/constants/permissions.js`. Hide a button when the user lacks its permission. The server enforces every one of these anyway.

| Module | Permissions |
|---|---|
| Inbox | `inbox.view`, `inbox.reply`, `inbox.note`, `inbox.assign` (needed for close, assign and bot mode), `inbox.contact.edit` |
| Contacts | `contact.view`, `contact.create`, `contact.edit`, `contact.delete`, `contact.import` |
| Campaigns | `campaign.view`, `campaign.create`, `campaign.edit`, `campaign.delete`, `campaign.launch` |
| Templates | `template.view`, `template.create`, `template.edit`, `template.delete` |
| Settings | `channel.manage` (channel list), `user.view` (team list) |

The default **agent** role has no `inbox.assign`. The **Close** button in the current mobile app therefore returns 403 for agents and must be hidden for them.

---

## 2. Realtime (SSE)

**Endpoint:** `GET /realtime/stream`, using the normal Bearer header (Dio can send it; browser EventSource cannot).

**Frame format:** `event: <name>\ndata: <json>\n\n`. The server also sends:
- `retry: 5000`
- a `connected` event
- a `: ping` comment every 25 s

**Events only carry ids. Always refetch over REST after an event.**

| Event | Payload | Mobile reaction |
|---|---|---|
| `message.received` | `conversation_id, message_id, is_new_conversation` | Refetch page 1 of the chat list and the unread badge. If that thread is open, refetch it and mark it read. |
| `message.sent` | `conversation_id, message_id` | Refetch the open thread and the list row. |
| `message.status.updated` | `conversation_id, message_id, status` | Refetch the open thread (updates the ticks). |
| `conversation.assigned` / `conversation.status` / `conversation.tagged` | `conversation_id, seq` | Refetch that conversation, the list and the counts. |
| `conversation.note` | `conversation_id, note_id, action` | Refetch the open thread. |
| `notification.created` | `notification_id, type, conversation_id` | Refetch the notifications badge. |

Implementation:
- Open the stream with `Dio.get(..., options: Options(responseType: ResponseType.stream))`. Split the bytes on blank lines and parse the `event:` and `data:` lines.
- Expose a `Stream<RealtimeEvent>` from `RealtimeService`, provided through `AppServices`.
- Connect after sign-in and disconnect on sign-out.
- Pause when the app goes to the background and reconnect when it resumes. On every reconnect, refetch the list, the counts and the open thread, because events missed while disconnected are not replayed.
- On a 401, refresh the token through `ApiClient`, then reconnect. Back off from 3 s, doubling up to 60 s.
- Batch events that arrive within 500 ms into one refetch, like the web client.
- `seq` gap: if `seq` jumps by more than 1, do a full refetch.
- Keep the existing polling timers only as a fallback while the stream is down. Raise their intervals to 30 s or more.
- Push notifications (FCM/APNs) are **not** available on the server. When the app is closed, nothing arrives. Treat push as a separate future task.

---

## 3. Chats module

Files:
- `lib/screens/chats/*`
- `lib/services/inbox_service.dart`
- `lib/models/conversation.dart`

### 3.1 List screen (`chats_screen.dart`)
- Tabs: **All / Mine / Unassigned**, with counts from `GET /conversations/counts` → `{ total, mine, unassigned, by_channel, by_team[] }`. The server receives `assignment=mine|unassigned`; never send `all`.
- Status filter chips: `all`, `open`, `pending`, `resolved`, `closed`.
- Keep `channel=whatsapp`. Instagram, email and SMS are out of scope for now.
- Search: the `search` param (1–100 characters), debounced by 350 ms (already in place).
- Page size: `limit` up to 100. Keep 30.
- Row: name, preview, time, unread badge, and an owner label. The owner label shows `assigned_to_name`, else the team name, else "Unassigned".
- Optional: a team filter (`team_id`) from `GET /teams`, and a tag filter (`tag_id`) from `GET /inbox/tags`.
- Bottom-nav unread badge: `GET /conversations/unread-count` → `{ count }`, refreshed by realtime.

### 3.2 Conversation model: new fields (`models/conversation.dart`)
- Status and ownership: `status` (now also `resolved`), `owning_team_id`, `owning_team {id,name}`.
- Tags and notes: `tags[]` (`{id,name,color}`), `tag_count`, `note_count`.
- Bot handover: `response_mode` (`bot` / `human`), `handoff_reason`.
- Session window: `session_window { state: open|closed, seconds_remaining }`. Use it instead of only `within_session_window`.
- Timestamps: `last_customer_message_at`.

### 3.3 Thread screen (`chat_thread_screen.dart`)
- Load from `GET /conversations/:id/thread?page&limit=50`.
  - Each item has `entry_type`.
  - `'message'` items carry the message fields.
  - `'note'` items are `{ id, author_name, body, created_at }`. Show notes as a yellow "internal note" bubble.
- **Check the ordering.** The server returns page 1 as the newest 50 entries in **ascending** order. The current mobile code assumes newest-first and reverses the list. Verify this against a real response and fix the reverse.
- Header:
  - Contact name.
  - Status picker (`PATCH /conversations/:id/status {status}`; needs `inbox.reply`).
  - Assign button (section 3.5; needs `inbox.assign`).
  - Contact-info button (section 3.7).
- Session-window banner: when `session_window.state == 'closed'`, hide free text and show "Send template". Optionally show the time left from `seconds_remaining`.
- Message `content_type` values to render:
  - Simple placeholder labels are fine for: `contacts`, `reaction`, `sticker`, `product`, `order`, `payment_request`, `call*`.
  - Real rendering for `text`, `image`, `video`, `audio`, `document`, `location` and `template`.
- Media:
  - `GET /conversations/messages/:messageId/media` returns the binary (Bearer header required).
  - `GET .../media/info` returns `{ file_size, mime_type, file_name, available }`.
  - Show "Media expired" when the API returns error code `MEDIA_EXPIRED`.
- Template messages: render `message.template` (header, body, footer, buttons) when it is present.
- Status ticks: `queued`, `sent`, `delivered`, `read`, `failed`. On `failed`, show `error_message`.

### 3.4 Composer
- **Reply tab:**
  - Text: `POST /conversations/:id/reply {body}`, max 4096 characters.
  - Attachment: send as multipart with `file` (max 16 MB), plus `content_type` (`image|video|audio|document`) and an optional `body` caption.
  - Show the message optimistically with a pending tick, and offer retry on failure, like the web client.
- **Note tab:** `POST /conversations/:id/notes {body}`, max 5000 characters, needs `inbox.note`. Delete with `DELETE /conversations/:id/notes/:noteId`; only the author or a user with `inbox.assign` may delete.
- **Template tab:**
  - Load templates with `GET /templates?channel=whatsapp&status=approved`.
  - Send `POST /reply` with `{ template_id, template_body_values: [..], template_params: {...} }`.
  - Templates with `{{n}}` variables are now **allowed**. Show one input per variable, pre-filled with `variables[i].sample`.
  - Show the header and button inputs from section 6.3.

### 3.5 Assign (needs `inbox.assign`)
- `POST /conversations/:id/assign` with `{ assigned_to: userId|null, owning_team_id?, expected_assignee_id: <current assigned_to> }`.
- Agent list from `GET /users` → `{ users[] }`; team list from `GET /teams`.
- On a 409 `ASSIGNMENT_CONFLICT`, show "Someone else changed the assignee", then reload.
- Close: `POST /conversations/:id/close`, also needs `inbox.assign`.
- Optional: bot / human toggle with `POST /conversations/:id/bot-mode {mode}`, which also needs `inbox.assign`.

### 3.6 New chat (`new_chat_screen.dart`)
1. Pick a contact (`GET /contacts?search&limit=50`).
2. Look for an existing conversation with `GET /conversations?contact_id=<id>&channel=all&limit=20`. This replaces the current search-based matching.
3. If one is found, open it.
4. If none is found, pick an approved template and fill its variables, then call `POST /conversations/start { contact_id, template_id, template_body_values?, template_params? }`. The response contains `conversation_id`; open that conversation. A 403 means the chat belongs to someone else.

### 3.7 Contact info sheet (new)
- `GET /conversations/:id/contact` → `{ id, full_name, phone, tags[] }`.
- Edit name and tags with `PATCH /conversations/:id/contact { full_name?, tags? }`. Needs `inbox.contact.edit` or admin.
- Conversation tags (labels):
  - Apply: `POST /conversations/:id/tags {tag_id}` or `{name, color?}`. Creating a new name needs `pipeline.manage`.
  - Remove: `DELETE /conversations/:id/tags/:tagId`.
  - Available tags: `GET /inbox/tags`.
- Show status, assignee, team and the notes list (`GET /conversations/:id/notes`).

---

## 4. Contacts module

Files:
- `lib/screens/contacts/*`
- `lib/services/contacts_service.dart`
- `lib/models/contact.dart`

### 4.1 List
- `GET /contacts?search&tag&limit&offset` → `data: { contacts[], total, limit, offset }`. This already works.
- Add a tag filter dropdown from `GET /contacts/tags` (rows with `{id, name}`). `ContactsService.tags()` already exists but is unused.
- Header stats: the total count, taken from `total`.
- Tapping a contact opens the **Contact detail** screen (section 4.2).
- At the top of the Contacts screen, add a segmented control: **Contacts | Segments**. This matches the web, where Segments is a tab inside Contacts. See section 5.

### 4.2 Contact detail screen (new)
- `GET /contacts/:id` returns the contact with `tags`.
- Show:
  - name, phone, email, instagram handle
  - WhatsApp opt-out badge (`opted_out_whatsapp`)
  - tags
  - `attributes` (key/value list)
  - created date
- Actions:
  - **Message**: opens the flow from section 3.6.
  - **Edit** (`contact.edit`).
  - **Delete** (`contact.delete`).

### 4.3 Create / edit form (`contact_form_sheet.dart`)
- Fields: `full_name`, `phone` (max 20), `email`, `instagram_handle` (new), and `tags` (comma-separated).
- The server requires either phone or email.
- On edit, **always send `tags`**, because the server replaces the whole list.
- Gate the buttons on `contact.create`, `contact.edit` and `contact.delete`.

### 4.4 Field security (masked values)
- The server may return masked phone and email values (for example `+91 98•••••10`) depending on the user's role. The contact may also include `field_access`.
- Show the masked value as read-only text.
- In the edit form, open masked fields **empty** with the hint "Hidden for your role. Type a new value to replace it."
- **Never send a masked value back.** If the field was not edited, omit it from the PATCH body.

### 4.5 Import (optional, low priority on mobile)
- Pick a CSV file and read it as text.
1. Call `POST /contacts/import {csvContent}`; the response contains `{jobId}`.
2. Poll `GET /contacts/import/:jobId/status` every 1.5 s.
3. When the status is `awaiting_review`, call `POST /contacts/import/:jobId/commit {skip_existing}`.
- Show the `created`, `updated`, `skipped_count` and `invalid_count` values from the commit response.
- Needs `contact.import`. This can stay web-only if time is short.

---

## 5. Segments module (new)

On the server, a "segment" is a **contact list**. There is no separate segments API.

**Data model:**
- `ContactList { id, name, type: 'static'|'dynamic', filter_rules, member_count, created_at }`.
- `filter_rules = { operator: 'AND'|'OR', conditions: [{ field, operator, value }] }`.

### 5.1 Endpoints
| Method | Path | Notes |
|---|---|---|
| GET | `/contacts/lists` | All lists and segments, each with `member_count` |
| POST | `/contacts/lists` | Static: `{ name, type:'static', contact_ids:[..] }` (at least 1). Dynamic: `{ name, type:'dynamic', filter_rules }`. Returns the list with `member_count`, plus a message such as "N contact(s) matched". Needs `contact.create`. |
| GET | `/contacts/lists/:id/preview` | `{ totalMatched, contacts:[first 100] }`. Re-runs the rules of a dynamic segment. |
| DELETE | `/contacts/lists/:id` | 409 if a campaign uses the list. Needs `contact.delete`. |

The server has **no update endpoint**. To change a segment, the user deletes it and creates a new one. Do not add an Edit button.

### 5.2 Segments list screen (new: `lib/screens/segments/segments_screen.dart`)
- Search by name on the device.
- Type filter: All / Static lists / Dynamic segments.
- Each row shows the name, a type badge and "N recipients". When N is 0, show it in red with the note "campaigns cannot launch".
- Tapping a row opens **View recipients** (`/preview`): a list of name, phone and email (masked), with an opted-out badge. Show "Showing first X of Y" when the list is cut off.
- Long-press or a menu offers **Delete**, with the confirmation "The contacts themselves are kept". Handle the 409 by showing "Used by a campaign".
- A floating action button opens **Create segment**.
- Empty state: "No lists or segments yet" with a **Create first segment** button.

### 5.3 Create segment screen (new: `create_segment_screen.dart`)
Common fields: **Name** (required) and a **Type** toggle (Static / Dynamic).

**Static mode**
- Contact picker with search, a tag filter, checkboxes, "Select all visible" and "Clear".
- Load contacts page by page from `GET /contacts`. The web loads up to 1000 at once; on mobile use paging plus search.
- Validation: at least one contact must be selected.

**Dynamic mode (rule builder)**
- **Match** selector:
  - "ALL rules" sends `AND`.
  - "ANY rule" sends `OR`.
- Each rule row has a **Field**, an **Operator** and a **Value**.
- **Field** options, the same as on the web:
  - `tag`
  - `full_name`
  - `email`
  - `phone`
  - `attributes.city` (allow a custom `attributes.<key>`)
- **Operator** options:
  - `equals`: for a tag the label is "has tag".
  - `not_equals`: for a tag the label is "does not have tag".
  - `contains`.
  - `exists`: for a tag the label is "has any tag"; this operator takes no value.
  - The server also supports `gt` and `lt`; offer them only for `attributes.*` fields.
- **Value** input depends on the field:
  - For `tag`: a chip picker filled from `GET /contacts/tags`, which also allows typing a new tag. Several chips are joined with commas into one `value`, and the server matches any of them, case-insensitively.
  - Other fields: a text input.
- Add-rule and remove-rule buttons.
- When there are several tag rules under AND, show a warning ("A contact must have ALL these tags") with a one-tap **Switch to ANY** button. This mirrors `CreateSegmentModal.tsx`.
- Before sending:
  - Drop rules with an empty value, except `exists` rules.
  - Remove duplicate rules (same field, operator and lower-cased value).
- **Check:** the web client drops `exists` rules because their value is empty. Test whether the server accepts `exists` with `value: ""`. If it does not, hide `exists`.

**Preview count**
- The server has no dry-run endpoint. Options:
  - (a) **Recommended:** after saving, show the `member_count` the server returns. If it is 0, warn and link to View recipients.
  - (b) Optional: show a live estimate on the device by evaluating the rules over the contacts already loaded, using the same logic as `previewMatches` in `client/src/components/contacts/CreateSegmentModal.tsx`. Label it "estimate".
- Help text: "A dynamic segment re-checks its rules every time a campaign launches."

### 5.4 Model and service changes
- `lib/models/contact_list.dart`: add `member_count`, `filter_rules`, `created_at`, plus a `SegmentRule` class.
- `lib/services/contacts_service.dart`: add `createList(...)`, `previewList(id)` and `deleteList(id)`.
  - Alternative: put these in a new `segments_service.dart` and register it in `lib/state/app_services.dart`.

---

## 6. Campaigns module

Files:
- `lib/screens/campaigns/*`
- `lib/services/campaigns_service.dart`
- `lib/models/campaign.dart`

### 6.1 List (`campaigns_screen.dart`)
- `GET /campaigns?channel=whatsapp&status&limit=50&offset`. The response is a bare array with no total; load more until a page has fewer than `limit` items.
- Status chips: `all`, `draft`, `scheduled`, `queued`, `sending`, `paused`, `completed`, `failed`, `cancelled`. `queued`, `paused` and `cancelled` are new.
- Summary at the top:
  - Total
  - Active (queued + sending)
  - Completed
  - Total sent (sum of `sent_count`)
- Card: name, status badge, audience (`total_recipients`), delivered, failed, and a progress bar of `(sent+failed)/total`.

### 6.2 Detail (`campaign_detail_sheet.dart`; consider a full screen)
- Data: `GET /campaigns/:id` and `GET /campaigns/:id/stats`. While the status is `queued` or `sending`, poll every 5 s.
- KPIs:
  - Total recipients
  - Sent
  - Delivered
  - Failed
  - Delivery % (delivered / sent)
- Actions, each gated on `campaign.launch` and confirmed first:

| Action | Shown when status is |
|---|---|
| Launch | `draft` or `scheduled` |
| Pause | `queued` or `sending` |
| Cancel | `scheduled`, `queued` or `sending` |
| Delete (`DELETE /campaigns/:id`, needs `campaign.delete`) | `draft` or `scheduled` |

- **Launch guard:** if the target list's `member_count` (from `GET /contacts/lists`) is 0, block the launch with "Audience is empty".
- **Recipients log (new):** `GET /campaigns/:id/recipients?limit=50&offset&status`.
  - Status filter: all, pending, queued, sent, delivered, read, failed, skipped.
  - Each row: `contactName`, `contactPhone`, status, `error_message`.
  - Paged with offset.
- Show the template **name** and sender **label**, not raw ids.
- Optional: edit name and schedule with `PATCH /campaigns/:id {name, scheduled_at}` while the status is `draft` or `scheduled` (needs `campaign.edit`).

### 6.3 Create wizard (`create_campaign_screen.dart`, as 4 steps)
1. **Settings:** campaign name (1–150 characters). Channel is fixed to WhatsApp.
2. **Template:** only approved templates, from `GET /templates?channel=whatsapp&status=approved`. Changing the template resets the variables.
3. **Audience:**
   - Sender from `GET /channel-accounts`, keeping connected WhatsApp accounts only. This needs `channel.manage`; on a 403, show "Ask an admin".
   - List or segment from `GET /contacts/lists`. Show the type badge and "N recipients". Show lists with 0 recipients as disabled.
   - Add a **"Create segment"** shortcut that opens section 5.3 and returns here.
4. **Review & schedule:**
   - Body preview with the `{{n}}` values filled in.
   - One input per `{{n}}`, giving `template_variables` (exactly as many as the highest n).
   - **Template params**, a new section that follows `client/src/utils/templateParams.ts`:
     - TEXT header with a variable: `template_params.header_text`.
     - IMAGE, VIDEO or DOCUMENT header: `template_params.header_media` (a URL); for documents, also `header_filename`.
     - URL button with a dynamic URL: `template_params.buttons[<index>].url_suffix`.
     - COPY_CODE button: `template_params.buttons[<index>].coupon_code`.
   - Optional schedule date and time. Send it as UTC ISO with milliseconds (`toApiTimestamp` already does this).
   - Buttons:
     - **Save as draft:** create only.
     - **Schedule:** create with `scheduled_at` set.
     - **Send now:** create, then `POST /campaigns/:id/launch`. Unlike the web, mobile should offer this.
- Payload: `{ name, channel:'whatsapp', channel_account_id, template_id, contact_list_id, template_variables, template_params, scheduled_at|null }`.

### 6.4 Model (`models/campaign.dart`)
Add these fields:
- `channel_account_id`
- `contact_list_id`
- `template_params`
- `created_by`
- `updated_at`

Add a new `CampaignRecipient` model: `id, contact_id, status, message_id, error_message, contactName, contactPhone, contactEmail, created_at`.

---

## 7. Templates module

Files:
- `lib/screens/templates/*`
- `lib/services/templates_service.dart`
- `lib/models/template.dart`

### 7.0 Scope choice (ask the product owner)
- **Option A (recommended for v1):** browse, view, submit, check status, sync, duplicate and delete. Creating templates stays on the web.
- **Option B:** also add a simple editor (section 7.3).

### 7.1 List (`templates_screen.dart`)
- Data: `GET /templates?channel=whatsapp&status&category&search`. There is no pagination.
- Filters:
  - Status chips: all, draft, pending ("In review"), approved, rejected, paused.
  - **Category** chips (new): MARKETING, UTILITY, AUTHENTICATION.
  - A search box (the service already supports `search`).
- Card: a WhatsApp-style preview (header, body, footer, buttons), category, status, language.
- Header action: **Sync from Meta**, which calls `POST /templates/sync`. Show the `{ imported, updated, skipped, total }` it returns. Needs `template.create`.

### 7.2 Detail sheet (`template_detail_sheet.dart`)
- Show:
  - the full preview, including `header_media_url` as an image or thumbnail
  - the variables with their samples
  - the buttons (type, text, url or phone)
  - `rejection_reason` when the template was rejected
- Actions:

| Action | Endpoint | When | Permission |
|---|---|---|---|
| Submit for review | `POST /templates/:id/submit` | draft or rejected | `template.edit` |
| Check review status | `GET /templates/:id/status` → `{ changed, status, rejectionReason }` | pending | — |
| Duplicate (new) | `POST /templates/:id/duplicate` | any | `template.create` |
| Delete (new) | `DELETE /templates/:id` | any | `template.delete` |

- When deleting an **approved** template, warn: "It stays approved on Meta".

### 7.3 Simple editor (only if Option B is chosen)
- Endpoints:
  - Create: `POST /templates`.
  - Edit: `PATCH /templates/:id`, allowed only for draft or rejected templates.
  - Header media upload: `POST /templates/header-media`, multipart `{header_type, file}`. It returns a `url` to store in `header_media_url`.
- Fields:
  - **Name:** lowercase `[a-z0-9_]`, spaces become `_`.
  - **Category.**
  - **Language:** default `en`.
  - **Header:** NONE / TEXT (max 60 characters, plus a sample) / IMAGE / VIDEO / DOCUMENT.
  - **Body:** max 1024 characters, with an "insert variable" button.
  - **Variable samples:** a name and sample for each `{{n}}`.
  - **Footer:** max 60 characters, no variables.
  - **Buttons:**
    - Up to 10 in total; button text max 25 characters.
    - QUICK_REPLY.
    - URL: at most 2.
    - PHONE_NUMBER: at most 1.
    - COPY_CODE: at most 1.
- Copy the validation rules from `client/src/pages/TemplateEditorPage.tsx`.

### 7.4 Model (`models/template.dart`)
Add these fields:
- `header_sample`
- `header_media_url`
- `subject`
- `external_template_id`
- `created_at`

Also add the button fields `url`, `url_example`, `phone_number` and `example`, and `variables[].type`.

---

## 8. Settings module

File: `lib/screens/settings/settings_screen.dart`. Split it into sub-screens.

The web `/settings` page is mostly a mock (its General, Notifications and Security tabs do not call the API), so mobile should build only the parts backed by real endpoints.

| Section | What it shows | Endpoint | Permission |
|---|---|---|---|
| **Profile** | name, email, phone, roles, last login | `GET /auth/me` | — |
| **Change password** (new) | current password, new (at least 8 characters, different from current), confirm | `POST /auth/change-password {currentPassword, newPassword}` | — |
| **Workspace** | tenant name and slug (read only) | from `/auth/me` | — |
| **Notifications** (new) | in-app notification list, mark read, mark all read, unread badge | `GET /notifications?page&limit`, `GET /notifications/unread-count`, `POST /notifications/:id/read`, `POST /notifications/read-all`. Refresh on the realtime `notification.created` event | — |
| **WhatsApp channels** (new, read only) | label, masked phone, verified name, status, quality rating, messaging limit | `GET /channel-accounts` | `channel.manage` |
| **Team** (new, read only) | users with roles and status | `GET /users` → `{users[]}` | `user.view` |
| **Appearance** | System / Light / Dark | local only (already done) | — |
| **Server** | API base URL | local only (already done) | — |
| **About** | real app version | `package_info_plus` | — |
| **Log out** | | `POST /auth/logout {refreshToken}` (already done) | — |

Hide any section the user lacks permission for.

The server has **no** endpoints for notification preferences or for editing the workspace name. Do not build those screens.

### 8.1 Login change
If `POST /auth/login` returns `data.requiresPasswordChange == true`:
1. Show a "Set a new password" step.
2. Call login again with the same body plus `newPassword`.

---

## 9. Navigation

Keep 5 bottom tabs: **Chats, Contacts, Campaigns, Templates, Settings**.

- **Segments** goes inside the Contacts tab as a segmented control (`Contacts | Segments`), matching the web layout. It can also be opened from campaign wizard step 3.
- Alternative, if the product owner wants Segments as a separate tab: 6 tabs is crowded, so move Templates into a "More" menu.
- Tab badges:
  - Chats: unread count.
  - Settings: unread notification count.
- Hide a tab whose `*.view` permission the user lacks, for example a user without `campaign.view`.

---

## 10. Suggested order of work

1. Foundation (section 1) and the login change (section 8.1).
2. Chats:
   - list filters, counts and the thread endpoint (3.1–3.3)
   - composer: templates with params, notes and attachments (3.4)
   - assign, status and contact info (3.5, 3.7)
   - new chat via `/start` (3.6)
3. Realtime SSE (section 2). Then reduce the polling.
4. Contacts: detail screen, tag filter, field security (4.1–4.4).
5. Segments: list, create (static and dynamic), preview, delete (section 5).
6. Campaigns: new statuses, recipients log, template params, "send now", delete (section 6).
7. Templates: category filter, duplicate, delete, richer preview (7.1–7.2). The editor (7.3) is optional.
8. Settings sub-screens (section 8).
9. Contact import (4.5) is optional.

---

## 11. Test checklist

- [ ] Log in with an agent account. Close, Assign and Bot mode are hidden. Reply and Notes work.
- [ ] Log in with an admin account. Everything is visible.
- [ ] An inbound WhatsApp message shows up in under 2 s while the app is open (SSE).
- [ ] Switch from Wi-Fi to mobile data, wait 15 minutes or more, and confirm the token refresh still works (fingerprint risk in section 0).
- [ ] When the 24 h window has closed, only templates can be sent. A template with `{{1}}` and an image header sends correctly.
- [ ] Image, document and voice attachments send, and inbound media renders.
- [ ] A masked phone number is never sent back in a PATCH.
- [ ] Dynamic segment `tag equals vip,gold` with OR gives `member_count` greater than 0, and the preview lists those contacts.
- [ ] Deleting a segment that a campaign uses shows the "Used by a campaign" message.
- [ ] Launching a campaign to an empty segment is blocked. "Send now" creates and launches. The recipients log updates while the campaign sends.
- [ ] Template Sync shows the imported and updated counts. Duplicate creates a draft.
- [ ] Change password works. The notifications list and the mark-all-read action work.

---

## 12. Reference files (for the developer)

**Server**
- Routes: `server/src/api/v1/{conversations,inbox,contacts,campaigns,templates,auth,users,teams,channel-accounts,notifications,realtime}/*.routes.js`
- Validators (exact field rules): `*.validator.js` / `*.validation.js` in the same folders
- Permissions: `server/src/constants/permissions.js`
- Realtime events: `server/src/realtime/realtime-hub.js`
- Segment rule evaluation: `server/src/core/contacts/use-cases/evaluate-dynamic-segment.use-case.js`

**Web UI to mirror**
- API calls: `client/src/store/services/{inboxApi,contactsApi,campaignsApi,templatesApi,authApi}.ts`
- Inbox: `client/src/pages/inbox/*` (Inbox, ConversationThread, MessageComposer, ContactInfoPanel)
- Segments: `client/src/components/contacts/{SegmentsTab,CreateSegmentModal,ViewRecipientsModal}.tsx`
- Campaigns: `client/src/pages/{Campaigns,CampaignWizard,CampaignDetail}.tsx`, `client/src/utils/templateParams.ts`
- Templates: `client/src/pages/{Templates,TemplateEditorPage}.tsx`
- Realtime handling: `client/src/hooks/useRealtime.ts`
