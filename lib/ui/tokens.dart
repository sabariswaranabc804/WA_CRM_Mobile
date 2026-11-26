import 'package:flutter/material.dart';

/// Design tokens — the single source of truth for colour, spacing and shape.
///
/// These mirror `client/tailwind.config.js` and `client/src/index.css` so the
/// mobile app and the web dashboard are visibly the same product. Nothing in
/// `screens/` should hardcode a hex value or a magic padding; it reaches for a
/// token instead, the same way the web client reaches for a Tailwind scale.

/// The Bulk Chat palette: cyan primary, emerald secondary, slate neutrals.
class AppColors {
  // ── Primary: cyan (tailwind `primary`) ──────────────────────────────
  static const primary50 = Color(0xFFECFEFF);
  static const primary100 = Color(0xFFCFFAFE);
  static const primary200 = Color(0xFFA5F3FC);
  static const primary300 = Color(0xFF67E8F9);
  static const primary400 = Color(0xFF22D3EE);
  static const primary500 = Color(0xFF06B6D4);
  static const primary600 = Color(0xFF0891B2);
  static const primary700 = Color(0xFF0E7490);
  static const primary800 = Color(0xFF155E75);
  static const primary900 = Color(0xFF164E63);

  /// The brand colour on light backgrounds (web uses primary-600 for buttons).
  static const primary = primary600;

  /// Dark mode lifts to primary-400/500 for contrast, as the web client does.
  static const primaryDark = primary400;

  // ── Secondary: emerald (tailwind `secondary`) ───────────────────────
  static const secondary50 = Color(0xFFF0FDF4);
  static const secondary400 = Color(0xFF4ADE80);
  static const secondary500 = Color(0xFF10B981);
  static const secondary600 = Color(0xFF059669);
  static const secondary700 = Color(0xFF047857);

  static const secondary = secondary500;

  // ── Neutrals: slate / gray, matching the web client's surfaces ──────
  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate700 = Color(0xFF334155);
  static const slate900 = Color(0xFF0F172A);

  /// `dark:bg-gray-950` / `gray-900` / `gray-800` from the web client.
  static const gray950 = Color(0xFF030712);
  static const gray900 = Color(0xFF111827);
  static const gray800 = Color(0xFF1F2937);
  static const gray400 = Color(0xFF9CA3AF);

  // ── Chat surfaces ───────────────────────────────────────────────────
  // The message thread keeps WhatsApp's conventions — a green outgoing
  // bubble on a warm wallpaper — because that is what the channel looks
  // like and what agents recognise. Everything around it is Bulk Chat.
  static const chatBgLight = Color(0xFFECE5DD);
  static const chatBgDark = Color(0xFF0B141A);
  static const bubbleOutLight = Color(0xFFD9FDD3);
  static const bubbleOutDark = Color(0xFF005C4B);
  static const bubbleInLight = Color(0xFFFFFFFF);
  static const bubbleInDark = Color(0xFF1F2C34);
  static const tick = Color(0xFF53BDEB); // Blue "read" ticks

  // ── Semantic ────────────────────────────────────────────────────────
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);
  static const dangerStrong = Color(0xFFDC2626);
  static const info = Color(0xFF3B82F6);
  static const neutral = Color(0xFF6B7280);

  // ── Brightness-aware helpers ────────────────────────────────────────

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// Body/subtitle colour for the active brightness.
  static Color subtitle(BuildContext context) =>
      _isDark(context) ? gray400 : slate500;

  /// Raised surface (cards, app bars, composer) for the active brightness.
  static Color surface(BuildContext context) =>
      _isDark(context) ? gray900 : Colors.white;

  /// The page background for the active brightness.
  static Color background(BuildContext context) =>
      _isDark(context) ? gray950 : Colors.white;

  /// The brand colour that reads correctly on the current background.
  static Color accent(BuildContext context) =>
      _isDark(context) ? primaryDark : primary;

  /// The chat wallpaper for the active brightness.
  static Color chatBackground(BuildContext context) =>
      _isDark(context) ? chatBgDark : chatBgLight;

  /// Outgoing bubble for the active brightness.
  static Color bubbleOut(BuildContext context) =>
      _isDark(context) ? bubbleOutDark : bubbleOutLight;

  /// Incoming bubble for the active brightness.
  static Color bubbleIn(BuildContext context) =>
      _isDark(context) ? bubbleInDark : bubbleInLight;

  /// The web client's signature button fill: a primary-600 → 700 gradient.
  static LinearGradient primaryGradient(BuildContext context) => LinearGradient(
        colors: _isDark(context)
            ? const [primary500, primary600]
            : const [primary600, primary700],
      );
}

/// Spacing scale. Use these instead of loose numbers in `EdgeInsets`.
class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 28;
  static const double huge = 40;
}

/// Corner radii. The web client rounds cards to `rounded-2xl` (16px) and
/// controls to `rounded-lg` (8px).
class AppRadius {
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double pill = 999;
}

/// Control heights, shared by buttons and inputs so rows line up.
class AppSizes {
  static const double buttonSm = 36;
  static const double buttonMd = 46;
  static const double buttonLg = 52;
  static const double avatarSm = 18;
  static const double avatarMd = 24;
  static const double avatarLg = 32;
}

/// The product name, as the web client presents it.
class AppBrand {
  static const name = 'Bulk Chat';
  static const logoAsset = 'assets/images/logo-bulkchat.png';
  static const tagline = 'Powered by Bulk Chat · Multi-channel bulk messaging';
}

/// How long the list debounces typing before it queries the API.
const kSearchDebounce = Duration(milliseconds: 350);

/// Stable per-contact avatar colour. Drawn from the brand's cyan→emerald range
/// so avatars sit inside the palette rather than fighting it.
const _avatarColors = <Color>[
  Color(0xFF0891B2), Color(0xFF06B6D4), Color(0xFF22D3EE),
  Color(0xFF0E7490), Color(0xFF10B981), Color(0xFF059669),
  Color(0xFF047857), Color(0xFF14B8A6), Color(0xFF0D9488),
  Color(0xFF3B82F6), Color(0xFF6366F1), Color(0xFF8B5CF6),
  Color(0xFFA855F7), Color(0xFFEC4899), Color(0xFFF59E0B),
];

Color avatarColorFor(int id) => _avatarColors[id.abs() % _avatarColors.length];
