import 'package:flutter/material.dart';

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

  /// Brand color on light backgrounds.
  static const primary = primary600;

  /// Dark mode lifts to primary-400 for contrast.
  static const primaryDark = primary400;

  // ── Secondary: emerald (tailwind `secondary`) ───────────────────────
  static const secondary50 = Color(0xFFF0FDF4);
  static const secondary400 = Color(0xFF4ADE80);
  static const secondary500 = Color(0xFF10B981);
  static const secondary600 = Color(0xFF059669);
  static const secondary700 = Color(0xFF047857);

  static const secondary = secondary500;

  // ── Neutrals: slate / gray ──────────────────────────────────────────
  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate700 = Color(0xFF334155);
  static const slate900 = Color(0xFF0F172A);

  static const gray950 = Color(0xFF030712);
  static const gray900 = Color(0xFF111827);
  static const gray800 = Color(0xFF1F2937);
  static const gray400 = Color(0xFF9CA3AF);

  // ── Chat surfaces (WhatsApp conventions) ────────────────────────────
  static const chatBgLight = Color(0xFFECE5DD);
  static const chatBgDark = Color(0xFF0B141A);
  static const bubbleOutLight = Color(0xFFD9FDD3);
  static const bubbleOutDark = Color(0xFF005C4B);
  static const bubbleInLight = Color(0xFFFFFFFF);
  static const bubbleInDark = Color(0xFF1F2C34);
  static const tick = Color(0xFF53BDEB); // Blue "read" ticks

  // Internal note styling
  static const noteBgLight = Color(0xFFFEF9C3); // yellow-100
  static const noteBorderLight = Color(0xFFFDE047); // yellow-300
  static const noteTextLight = Color(0xFF713F12); // yellow-900
  static const noteBgDark = Color(0xFF422006); // yellow-950
  static const noteBorderDark = Color(0xFF854D0E); // yellow-800
  static const noteTextDark = Color(0xFFFEF08A); // yellow-200

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

  static Color subtitle(BuildContext context) =>
      _isDark(context) ? gray400 : slate500;

  static Color surface(BuildContext context) =>
      _isDark(context) ? gray900 : Colors.white;

  static Color background(BuildContext context) =>
      _isDark(context) ? gray950 : Colors.white;

  static Color card(BuildContext context) =>
      _isDark(context) ? gray900 : Colors.white;

  static Color border(BuildContext context) =>
      _isDark(context) ? gray800 : slate200;

  static Color accent(BuildContext context) =>
      _isDark(context) ? primaryDark : primary;

  static Color chatBackground(BuildContext context) =>
      _isDark(context) ? chatBgDark : chatBgLight;

  static Color bubbleOut(BuildContext context) =>
      _isDark(context) ? bubbleOutDark : bubbleOutLight;

  static Color bubbleIn(BuildContext context) =>
      _isDark(context) ? bubbleInDark : bubbleInLight;

  static Color noteBg(BuildContext context) =>
      _isDark(context) ? noteBgDark : noteBgLight;

  static Color noteBorder(BuildContext context) =>
      _isDark(context) ? noteBorderDark : noteBorderLight;

  static Color noteText(BuildContext context) =>
      _isDark(context) ? noteTextDark : noteTextLight;

  static LinearGradient primaryGradient(BuildContext context) => LinearGradient(
        colors: _isDark(context)
            ? const [primary500, primary600]
            : const [primary600, primary700],
      );

  /// Status badge colors: returns (bg, fg, border)
  static ({Color bg, Color fg, Color border}) statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
      case 'active':
      case 'approved':
      case 'completed':
      case 'delivered':
      case 'read':
        return (
          bg: const Color(0xFFECFDF5),
          fg: const Color(0xFF047857),
          border: const Color(0xFFA7F3D0),
        );
      case 'pending':
      case 'scheduled':
      case 'sending':
      case 'queued':
      case 'sent':
        return (
          bg: const Color(0xFFFFFBEB),
          fg: const Color(0xFFB45309),
          border: const Color(0xFFFDE68A),
        );
      case 'resolved':
        return (
          bg: const Color(0xFFEFF6FF),
          fg: const Color(0xFF1D4ED8),
          border: const Color(0xFFBFDBFE),
        );
      case 'closed':
      case 'paused':
      case 'cancelled':
      case 'draft':
        return (
          bg: const Color(0xFFF1F5F9),
          fg: const Color(0xFF475569),
          border: const Color(0xFFCBD5E1),
        );
      case 'failed':
      case 'rejected':
        return (
          bg: const Color(0xFFFEF2F2),
          fg: const Color(0xFFB91C1C),
          border: const Color(0xFFFECACA),
        );
      default:
        return (
          bg: const Color(0xFFF1F5F9),
          fg: const Color(0xFF475569),
          border: const Color(0xFFCBD5E1),
        );
    }
  }
}

/// Stable per-contact avatar color drawn from cyan/emerald palette.
const _avatarColors = <Color>[
  Color(0xFF0891B2), Color(0xFF06B6D4), Color(0xFF22D3EE),
  Color(0xFF0E7490), Color(0xFF10B981), Color(0xFF059669),
  Color(0xFF047857), Color(0xFF14B8A6), Color(0xFF0D9488),
  Color(0xFF3B82F6), Color(0xFF6366F1), Color(0xFF8B5CF6),
  Color(0xFFA855F7), Color(0xFFEC4899), Color(0xFFF59E0B),
];

Color avatarColorFor(int id) => _avatarColors[id.abs() % _avatarColors.length];
