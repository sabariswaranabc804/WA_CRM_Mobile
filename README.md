# Bulk Chat — mobile app

A Flutter client for **tenants** (workspace agents). It talks to the same
`server/` API as the web `client/`, and wears the same brand: the Bulk Chat
logo, Inter, and the cyan/emerald palette from `client/tailwind.config.js`.

The message thread is the one deliberate exception — it keeps WhatsApp's
conventions (green outgoing bubble, warm wallpaper, delivery ticks) because
that is what the channel looks like and what agents recognise. Everything
around it is Bulk Chat.

## What it does

Five destinations in a WhatsApp-style bottom bar:

| Tab | What it does |
| --- | --- |
| **Chats** | The inbox. Conversation list with unread badges, search and status filters; threads with WhatsApp bubbles, day dividers and delivery ticks. |
| **Contacts** | Search, browse, add, edit and delete contacts, with tags. |
| **Campaigns** | Compose a broadcast, track progress, launch / pause / cancel. |
| **Templates** | Browse the catalogue with a bubble preview, submit for Meta review, import from the WABA. |
| **Settings** | Profile, workspace, theme (System/Light/Dark), server URL and log out. |

A floating **+** sits just above the bottom bar: "new chat" on Chats, "add
contact" on Contacts.

**Login only — there is no registration.** Workspaces are provisioned on the
web (`POST /auth/register`); agents only sign in here. Login needs three
fields, because one email can exist in several workspaces:

- **Workspace** — the tenant slug (`acme-corp`); slugified client-side the same
  way `login.use-case.js` does it, so "Acme Corp" also works
- **Email**
- **Password**

## Running it

Start the API first — it listens on **3001**:

```bash
cd server && npm run dev
```

Then run the app:

```bash
cd mobileapp && flutter run
```

The default API URL is picked per platform: `http://10.0.2.2:3001/api/v1` on
the Android emulator (10.0.2.2 is the host machine from inside the emulator),
`http://localhost:3001/api/v1` elsewhere.

For a physical device, point it at your machine's LAN address — either at build
time:

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.5:3001/api/v1
```

or at runtime via **Server settings** on the login screen (persisted, no
rebuild needed). Whichever host you use must be listed in the server's
`ALLOWED_ORIGINS`.

## Architecture

Layered, with dependencies pointing one way — `screens` → `state`/`services` →
`core`, and everything presentational in `ui`:

```
lib/
  core/        infrastructure: config, API client, token storage,
               formatters, JSON coercion, debouncer
  models/      API payload types (Conversation, Message, Contact, …)
  services/    one class per API area — the only place that knows routes
  state/       AuthState (ChangeNotifier) + the service container
  ui/          the design system (see below)
  widgets/     app-level composites that need state (ServerUrlDialog)
  screens/     one folder per tab; each owns its own list state
```

State is `provider` + `ChangeNotifier`. Screens hold their own list state and
call services; nothing in `ui/` knows the API, the models or app state.

### Creating a campaign

`POST /campaigns` needs four ids plus an optional time, so
`CreateCampaignScreen` loads the three pickers up front — approved templates,
contact lists, connected WhatsApp senders — and enables Create only once every
choice is made. A single sender is auto-selected.

Scheduling is the one optional setting, and it decides the resulting status:
leave it off for a `draft` you launch by hand, set a time for a `scheduled`
campaign.

**Template placeholders.** A template whose body contains `{{1}}`, `{{2}}`, …
gets an extra "Message values" step, one input per placeholder, prefilled with
the sample the template was submitted to Meta with and previewed live in a
WhatsApp bubble. The values are stored on the campaign
(`campaigns.template_variables`, migration 006) and are the **same for every
recipient** — per-contact values would need a mapping to contact fields and are
not modelled.

`create-campaign.use-case.js` rejects a count mismatch up front, because Meta
would otherwise reject the send once per recipient, far too late to act on.
Note that the *sample* values in the web Template Editor exist only for Meta's
review submission; they are never sent.

Two more details worth keeping in mind when touching this:

- `scheduled_at` is validated as `z.string().datetime({ precision: 3 })`, which
  rejects both second-only and microsecond timestamps. `toApiTimestamp()`
  truncates to exactly three fractional digits in UTC, because Dart's
  `toIso8601String()` emits six whenever microseconds are non-zero.
- Listing senders needs the CHANNEL_MANAGE permission. A 403 is caught and
  surfaced as "ask an admin for the Channel Manage permission" rather than
  failing the whole screen.

### Theme mode

`ThemeState` owns the light/dark preference and persists it under the `theme`
key. Settings → **Appearance** offers three options; the web client has only
light and dark, and mobile adds **System**, which follows the device setting
and is the default. An unrecognised stored value falls back to System.

`TokenStorage` depends on a narrow `KeyValueStore` interface rather than on
`FlutterSecureStorage` directly, so tests substitute `InMemoryKeyValueStore`
instead of a keystore that does not exist under `flutter test`.

### The design system (`lib/ui/`)

One import — `import '../../ui/ui.dart';` — gives a screen every primitive.
The API deliberately mirrors the React client's (`variant` / `size` /
`isLoading`, and `label` / `error` / `helperText`) so the two front ends read
the same way.

```
ui/
  tokens.dart          AppColors, AppSpacing, AppRadius, AppSizes, AppBrand
  theme.dart           builds the Material themes from those tokens
  components/          the reusable widgets
  ui.dart              barrel export
```

#### Brand parity with the web client

| Token | Source | Value |
| --- | --- | --- |
| Primary | `tailwind.config.js` → `primary` | cyan, 50–900 (`primary-600` for buttons) |
| Secondary | `tailwind.config.js` → `secondary` | emerald, `#10b981` |
| Neutrals | web surfaces | slate in light, `gray-950`/`gray-900` in dark |
| Font | `index.css` → `fontFamily.sans` | **Inter** 400/500/600/700 |
| Logo | `client/public/logo-bulkchat.png` | copied to `assets/images/` |
| Product name | `AppBrand.name` | "Bulk Chat" |

Inter is **bundled** in `assets/fonts/` rather than fetched at runtime (the web
client `@import`s it from Google Fonts), so the app renders correctly offline
and on first launch.

`AppButton`'s primary variant reproduces the web client's signature fill — a
`primary-600 → 700` gradient with a tinted shadow — which Material has no
native equivalent for, so it is painted behind a transparent button.

One deliberate deviation: the logo's "Bulk" is dark navy and nearly vanishes on
a dark background (the web client has the same issue on its `gray-900` auth
card). `AppLogo` sets the mark on a white plate in dark mode rather than
tinting it white, which would discard the cyan and emerald that carry the
brand. Pass `plateOnDark: false` to opt out.

| Component | Replaces |
| --- | --- |
| `AppButton` | Every button. 6 variants (`primary`, `secondary`, `outline`, `ghost`, `danger`, `dangerOutline`), 3 sizes, built-in loading spinner that also disables the button so it cannot double-submit. |
| `AppInput` / `AppSearchField` | Every text field. `isPassword` manages its own show/hide toggle. |
| `AppAsyncListView<T>` | The loading / error / empty / loaded / paginating state machine, plus pull-to-refresh and scroll-to-load-more. Used by 5 screens. |
| `AppFilterBar` | The status chip strip on Chats, Campaigns and Templates. |
| `AppSearchAppBar` + `AppSearchAction` | The search-mode app bar on Chats and Contacts. |
| `AppFormSheet` / `AppDraggableSheet` | The grabber + header + keyboard handling every bottom sheet needs. |
| `showConfirmDialog` / `showTextPromptDialog` | Confirmation and prompt dialogs. |
| `AppBadge` / `AppCountBadge` | Status pills and the unread bubble. `statusColor()` is the single status→colour map. |
| `AppCard` / `AppBubble` | Content cards and the WhatsApp bubble shape (shared by the chat thread and template previews, so a preview matches what actually sends). |
| `AppEmptyState` / `AppErrorState` / `AppLoader` / `AppNotice` | Placeholder and feedback states. |
| `AppAvatar`, `AppLogo`, `AppMetric`, `AppStatTile`, `AppDetailRow`, `AppSectionHeader` | Smaller shared pieces. |

Screens no longer hardcode colours or paddings — those come from `AppColors`
and `AppSpacing`, so a token change propagates everywhere at once.

### Auth

The web client uses httpOnly cookies, which a mobile client cannot. Login also
returns the JWT pair in the response body, so this app uses **bearer tokens**
stored in the platform keystore/keychain (`flutter_secure_storage`).

`ApiClient` attaches the token, and on a 401 refreshes once via
`POST /auth/refresh` and retries; concurrent 401s share a single refresh. If
the refresh fails, the app drops to the login screen.

CSRF headers are deliberately not sent. `csrfProtection` runs in `app.js`
*before* any route-level `authenticate`, so `req.user` is unset there and the
check short-circuits — it only guards cookie sessions.

### Realtime

There is none: `server/src/realtime/` is empty. The chat list and open threads
**poll** instead (15s and 10s), paused while the app is backgrounded.

## Known gaps

These are limits of the current API, not oversights:

1. **New chats cannot be started.** There is no `POST /conversations` — threads
   are opened by an inbound webhook, an automation or a campaign. The **+**
   opens an existing conversation for a contact and explains the situation when
   there isn't one.
2. **Templates with `{{n}}` placeholders cannot be sent.**
   `send-reply.use-case.js` posts an empty `components` array, so Meta rejects
   them. The picker lists them but blocks selection rather than producing a
   failed send.
3. **No media send.** The Meta client has `downloadMedia` but no upload, so the
   composer is text and templates only. Inbound media shows as a labelled
   placeholder (📷 Photo).
4. **Launching a campaign queues it but nothing sends it yet.**
   `InMemoryQueueProducer` pushes jobs into an array and `server/src/jobs/` has
   no worker consuming them.

## Android notes

- `INTERNET` permission is in the main manifest (release builds need it too).
- `usesCleartextTraffic` is enabled **only** in the debug and profile manifests,
  so plain-http local development works while release builds stay HTTPS-only.
- `flutter_secure_storage` is held at 10.x — see the comment in `pubspec.yaml`.

## Tests

```bash
flutter test
```

61 tests across five files:

- `models_test.dart` — JSON coercion (MSSQL returns BIT as 0/1), conversation
  preview and title fallbacks, pagination envelopes, and the
  template-placeholder detection that gates sending.
- `formatters_test.dart` — the slug rule shared with `login.use-case.js`,
  initials, and the WhatsApp-style timestamps.
- `ui_components_test.dart` — widget tests for the design system: a loading
  `AppButton` refuses taps, `AppInput` toggles password visibility,
  `AppFilterBar` reports raw API values rather than display labels, and
  `AppAsyncListView` renders the right one of its five states.
- `campaign_test.dart` — the millisecond-precision timestamp the campaign validator demands, progress maths, and `CampaignCard` laid out at 375pt to catch overflows.
- `theme_state_test.dart` — theme persistence and restore, the fallback for an
  unrecognised stored value, and widget tests that pump the real Settings
  screen to confirm the selector switches and saves.
