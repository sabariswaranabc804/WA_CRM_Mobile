Role & Architecture Standard

You are an expert Flutter engineer building enterprise-grade mobile features for the WhatsApp CRM client (wa_crm_mobile). Implement the module [chat] following the Feature-First Clean Architecture pattern locked in lib/features/auth.

1. Context & Reference Scope
Target Directory: lib/features/chat/
Reference Logic & API Spec: Inspect old_code/[old_code\lib\screens\chats] ONLY to understand business logic, endpoints, query parameters, and payload structures.
UI Policy: Do NOT copy the old UI. Build a modern, responsive, WhatsApp-grade UI using the design system tokens and Material 3 theme.
## 2. Directory & File Blueprint

Create the following structure under `lib/features/chat/`:

```
lib/features/chat/
├── data/
│   ├── chat_repository.dart               # API & storage operations + @riverpod provider
│   └── chat_repository.g.dart             # Auto-generated code
├── domain/
│   └── models/
│       ├── chat_conversation.dart         # Freezed immutable conversation model
│       ├── chat_conversation.freezed.dart # Auto-generated Freezed
│       ├── chat_conversation.g.dart       # Auto-generated JSON serialization
│       ├── chat_message.dart              # Freezed immutable message model
│       ├── chat_message.freezed.dart      # Auto-generated Freezed
│       ├── chat_message.g.dart            # Auto-generated JSON serialization
│       └── chat_params.dart               # Strongly-typed Freezed Request DTOs
└── presentation/
    ├── controllers/
    │   ├── chat_controller.dart           # @riverpod Notifier
    │   ├── chat_controller.g.dart         # Auto-generated controller
    │   ├── chat_controller_state.dart     # Freezed immutable UI state
    │   └── chat_controller_state.freezed.dart # Auto-generated state
    ├── screens/
    │   ├── chats_screen.dart              # Active conversations list
    │   ├── chat_thread_screen.dart        # Message thread & interactive chat
    │   └── new_chat_screen.dart           # Start conversation with contact/number
    └── widgets/
        ├── chat_tile.dart                 # Extracted list item
        ├── chat_message_bubble.dart       # Incoming/outgoing bubble
        └── template_picker_sheet.dart     # 24h WhatsApp approved template picker
```

---
## 3. Strict Implementation Rules (Golden Constraints)
1. **Defensive Model Mapping (Snake_Case to CamelCase)**:
   - Backend MSSQL APIs return keys in `snake_case` (e.g., `tenant_id`, `created_at`, `role_ids`).
   - Every Freezed model property MUST be mapped explicitly using `@JsonKey(name: 'snake_case_key')`.
   - Never assume fields are non-null unless strictly guaranteed; use `@Default([])` for lists and nullable types (`String?`, `int?`) for optional fields.
2. **Type-Safe Request DTOs**:
   - NEVER pass untyped `Map<String, dynamic>` across controller and repository boundaries.
   - Define dedicated Freezed DTOs (e.g., `[ACTION]Params`) for all request payloads.
3. **Clean Error Handling & User Feedback**:
   - Network calls MUST use `ApiClient` (which auto-unwraps responses and maps failures to `ApiException.fromDio()`).
   - Controllers MUST catch `ApiException` to expose `e.message` to the UI state.
   - Screens MUST display errors via `showAppSnack(context, error, isError: true)`. Raw Dio technical exceptions must NEVER reach the UI.
4. **Design Tokens Only (Zero Magic Numbers & Raw Colors)**:
   - Colors: Use `AppColors.*(context)` or semantic tokens (`AppColors.primary500`, `AppColors.accent(context)`). Never write raw hex codes (`Color(0xFF...)`).
   - Spacing & Radii: Use `AppSpacing.*` and `AppRadius.*`. Never write hardcoded padding/margin numbers.
   - Typography: Use `Theme.of(context).textTheme.*` or `AppTypography.*`.
   - Reusable UI: Reuse components from `lib/shared/widgets/` (`AppButton`, `AppInput`, `AppCard`, `AppBadge`, `AppLoader`, `AppAvatar`, `AppSearchAppBar`). Extract repeated UI blocks into `presentation/widgets/`.
5. **Riverpod 2.x Code Generation**:
   - Use `@riverpod` annotations for repositories and controllers.
   - Inject dependencies via Inversion of Control: `ref.watch(apiClientProvider)` and `ref.watch(tokenStorageProvider)`.
---

## 5.  app colors
   * appclors globel handle alrady okay app_logo color mange corrctly   ,ifincst later feature logo chage color chage  globel file ap_color file only change  full app chaaged right
## 4. Verification & Completion Contract
After generating or editing files:
1. Run `dart run build_runner build -d` to compile all Riverpod and Freezed part files.
2. Run `dart analyze` to guarantee **0 errors and 0 warnings**.
3. Run `flutter test` to ensure existing smoke tests and unit tests remain green.