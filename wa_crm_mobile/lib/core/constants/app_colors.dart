
import 'package:flutter/material.dart';

/// Bulk Chat centralized color system.
///
/// Each color category has one base color.
/// All shades are generated automatically from that base.
class AppColors {
  AppColors._();

  // ============================================================
  // BASE COLORS
  // Change only these values to update each category's palette.
  // ============================================================

  static const Color primary = Color(0xFF25D366);
  static const Color secondary = Color(0xFF10B981);

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  static const Color neutral = Color(0xFF64748B);

  // ============================================================
  // SHADE GENERATOR
  // Positive amount = lighter
  // Negative amount = darker
  // ============================================================

  static Color _shade(Color base, double amount) {
    if (amount >= 0) {
      return Color.lerp(base, Colors.white, amount)!;
    }

    return Color.lerp(base, Colors.black, -amount)!;
  }

  // ============================================================
  // SHADE GENERATION
  // ============================================================

  static Color _shade50(Color base) => _shade(base, 0.94);
  static Color _shade100(Color base) => _shade(base, 0.84);
  static Color _shade200(Color base) => _shade(base, 0.68);
  static Color _shade300(Color base) => _shade(base, 0.48);
  static Color _shade400(Color base) => _shade(base, 0.25);
  static Color _shade500(Color base) => base;
  static Color _shade600(Color base) => _shade(base, -0.10);
  static Color _shade700(Color base) => _shade(base, -0.22);
  static Color _shade800(Color base) => _shade(base, -0.34);
  static Color _shade900(Color base) => _shade(base, -0.46);

  // ============================================================
  // PRIMARY PALETTE
  // ============================================================

  static Color get primary50 => _shade50(primary);
  static Color get primary100 => _shade100(primary);
  static Color get primary200 => _shade200(primary);
  static Color get primary300 => _shade300(primary);
  static Color get primary400 => _shade400(primary);
  static Color get primary500 => _shade500(primary);
  static Color get primary600 => _shade600(primary);
  static Color get primary700 => _shade700(primary);
  static Color get primary800 => _shade800(primary);
  static Color get primary900 => _shade900(primary);

  /// Brand color for dark mode.
  static Color get primaryDark => primary400;

  // ============================================================
  // SECONDARY PALETTE
  // ============================================================

  static Color get secondary50 => _shade50(secondary);
  static Color get secondary100 => _shade100(secondary);
  static Color get secondary200 => _shade200(secondary);
  static Color get secondary300 => _shade300(secondary);
  static Color get secondary400 => _shade400(secondary);
  static Color get secondary500 => _shade500(secondary);
  static Color get secondary600 => _shade600(secondary);
  static Color get secondary700 => _shade700(secondary);
  static Color get secondary800 => _shade800(secondary);
  static Color get secondary900 => _shade900(secondary);

  // ============================================================
  // SUCCESS PALETTE
  // ============================================================

  static Color get success50 => _shade50(success);
  static Color get success100 => _shade100(success);
  static Color get success200 => _shade200(success);
  static Color get success300 => _shade300(success);
  static Color get success400 => _shade400(success);
  static Color get success500 => _shade500(success);
  static Color get success600 => _shade600(success);
  static Color get success700 => _shade700(success);
  static Color get success800 => _shade800(success);
  static Color get success900 => _shade900(success);

  // ============================================================
  // WARNING PALETTE
  // ============================================================

  static Color get warning50 => _shade50(warning);
  static Color get warning100 => _shade100(warning);
  static Color get warning200 => _shade200(warning);
  static Color get warning300 => _shade300(warning);
  static Color get warning400 => _shade400(warning);
  static Color get warning500 => _shade500(warning);
  static Color get warning600 => _shade600(warning);
  static Color get warning700 => _shade700(warning);
  static Color get warning800 => _shade800(warning);
  static Color get warning900 => _shade900(warning);

  // ============================================================
  // DANGER PALETTE
  // ============================================================

  static Color get danger50 => _shade50(danger);
  static Color get danger100 => _shade100(danger);
  static Color get danger200 => _shade200(danger);
  static Color get danger300 => _shade300(danger);
  static Color get danger400 => _shade400(danger);
  static Color get danger500 => _shade500(danger);
  static Color get danger600 => _shade600(danger);
  static Color get danger700 => _shade700(danger);
  static Color get danger800 => _shade800(danger);
  static Color get danger900 => _shade900(danger);

  static Color get dangerStrong => danger700;

  // ============================================================
  // INFO PALETTE
  // ============================================================

  static Color get info50 => _shade50(info);
  static Color get info100 => _shade100(info);
  static Color get info200 => _shade200(info);
  static Color get info300 => _shade300(info);
  static Color get info400 => _shade400(info);
  static Color get info500 => _shade500(info);
  static Color get info600 => _shade600(info);
  static Color get info700 => _shade700(info);
  static Color get info800 => _shade800(info);
  static Color get info900 => _shade900(info);

  // ============================================================
  // NEUTRAL PALETTE
  // ============================================================

  static Color get neutral50 => _shade50(neutral);
  static Color get neutral100 => _shade100(neutral);
  static Color get neutral200 => _shade200(neutral);
  static Color get neutral300 => _shade300(neutral);
  static Color get neutral400 => _shade400(neutral);
  static Color get neutral500 => _shade500(neutral);
  static Color get neutral600 => _shade600(neutral);
  static Color get neutral700 => _shade700(neutral);
  static Color get neutral800 => _shade800(neutral);
  static Color get neutral900 => _shade900(neutral);

  // ============================================================
  // SLATE / GRAY COMPATIBILITY
  // Retains existing property names used in your application.
  // ============================================================

  static Color get slate50 => neutral50;
  static Color get slate100 => neutral100;
  static Color get slate200 => neutral200;
  static Color get slate400 => neutral400;
  static Color get slate500 => neutral500;
  static Color get slate700 => neutral700;
  static Color get slate900 => neutral900;

  static Color get gray950 => _shade(neutral, -0.62);
  static Color get gray900 => _shade(neutral, -0.55);
  static Color get gray800 => neutral800;
  static Color get gray400 => neutral400;

  // ============================================================
  // CHAT SURFACES
  // Independent colors to preserve WhatsApp-style appearance.
  // ============================================================

  static const Color chatBgLight = Color(0xFFECE5DD);
  static const Color chatBgDark = Color(0xFF0B141A);

  static const Color bubbleOutLight = Color(0xFFD9FDD3);
  static const Color bubbleOutDark = Color(0xFF005C4B);

  static const Color bubbleInLight = Color(0xFFFFFFFF);
  static const Color bubbleInDark = Color(0xFF1F2C34);

  static const Color tick = Color(0xFF53BDEB);

  // ============================================================
  // INTERNAL NOTES
  // ============================================================

  static const Color noteBgLight = Color(0xFFFEF9C3);
  static const Color noteBorderLight = Color(0xFFFDE047);
  static const Color noteTextLight = Color(0xFF713F12);

  static const Color noteBgDark = Color(0xFF422006);
  static const Color noteBorderDark = Color(0xFF854D0E);
  static const Color noteTextDark = Color(0xFFFEF08A);

  // ============================================================
  // BRIGHTNESS-AWARE HELPERS
  // ============================================================

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

  static LinearGradient primaryGradient(BuildContext context) =>
      LinearGradient(
        colors: _isDark(context)
            ? [primary500, primary600]
            : [primary600, primary700],
      );

  /// Returns dynamic (bg, fg) color pair for contact avatars.
  /// Generates the 3 aesthetic mockup variations (primary-tinted, solid primary,
  /// neutral-tinted) based on contact ID and current theme brightness.
  /// Changing [primary] base color automatically updates all contact avatars.
  static ({Color bg, Color fg}) avatarColors(BuildContext context, int id) {
    final isDark = _isDark(context);
    final variant = id.abs() % 3;

    switch (variant) {
      case 0:
        return (
          bg: isDark ? primaryDark.withValues(alpha: 0.18) : primary50,
          fg: isDark ? primary300 : primary700,
        );
      case 1:
        return (
          bg: isDark ? primary500 : primary,
          fg: Colors.white,
        );
      case 2:
      default:
        return (
          bg: isDark ? gray800 : neutral100,
          fg: isDark ? neutral200 : neutral700,
        );
    }
  }

  // ============================================================
  // STATUS COLORS
  // Returns background, foreground and border.
  // ============================================================

  static ({Color bg, Color fg, Color border}) statusColor(
    String status,
  ) {
    switch (status.toLowerCase()) {
      case 'open':
      case 'active':
      case 'approved':
      case 'completed':
      case 'delivered':
      case 'read':
        return (
          bg: success50,
          fg: success700,
          border: success200,
        );

      case 'pending':
      case 'scheduled':
      case 'sending':
      case 'queued':
      case 'sent':
        return (
          bg: warning50,
          fg: warning700,
          border: warning200,
        );

      case 'resolved':
        return (
          bg: info50,
          fg: info700,
          border: info200,
        );

      case 'closed':
      case 'paused':
      case 'cancelled':
      case 'draft':
        return (
          bg: neutral100,
          fg: neutral700,
          border: neutral200,
        );

      case 'failed':
      case 'rejected':
        return (
          bg: danger50,
          fg: danger700,
          border: danger200,
        );

      default:
        return (
          bg: neutral100,
          fg: neutral700,
          border: neutral200,
        );
    }
  }
}

// ============================================================
// AVATAR COLORS
// Stable per-contact avatar colors.
// ============================================================

const List<Color> _avatarColors = [
  Color(0xFF0891B2),
  Color(0xFF06B6D4),
  Color(0xFF22D3EE),
  Color(0xFF0E7490),
  Color(0xFF10B981),
  Color(0xFF059669),
  Color(0xFF047857),
  Color(0xFF14B8A6),
  Color(0xFF0D9488),
  Color(0xFF3B82F6),
  Color(0xFF6366F1),
  Color(0xFF8B5CF6),
  Color(0xFFA855F7),
  Color(0xFFEC4899),
  Color(0xFFF59E0B),
];

Color avatarColorFor(int id) =>
    _avatarColors[id.abs() % _avatarColors.length];
