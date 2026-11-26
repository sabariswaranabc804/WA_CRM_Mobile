import 'package:flutter/material.dart';

import 'tokens.dart';

/// Builds the Material themes from the design tokens.
///
/// Mirrors the web client: Inter throughout, cyan primary, emerald secondary,
/// white / slate-50 surfaces in light mode and gray-950 / gray-900 in dark.
/// Components read from the theme wherever possible so a token change
/// propagates everywhere.

const kFontFamily = 'Inter';

ThemeData buildLightTheme() => _build(Brightness.light);

ThemeData buildDarkTheme() => _build(Brightness.dark);

ThemeData _build(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary500,
    brightness: brightness,
  ).copyWith(
    primary: isDark ? AppColors.primaryDark : AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.dangerStrong,
    surface: isDark ? AppColors.gray950 : Colors.white,
  );

  final onSurface = isDark ? Colors.white : AppColors.slate900;
  final subtitle = isDark ? AppColors.gray400 : AppColors.slate500;

  return ThemeData(
    useMaterial3: true,
    fontFamily: kFontFamily,
    colorScheme: scheme,
    scaffoldBackgroundColor: isDark ? AppColors.gray950 : Colors.white,

    // The web client's chrome is a light surface with dark text, not a
    // saturated brand bar — the app bar follows it.
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? AppColors.gray900 : Colors.white,
      foregroundColor: onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: kFontFamily,
        color: onSurface,
        fontSize: 19,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: onSurface),
      shape: Border(
        bottom: BorderSide(
          color: isDark ? AppColors.gray800 : AppColors.slate200,
        ),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: isDark ? AppColors.primary500 : AppColors.primary600,
      foregroundColor: Colors.white,
      elevation: 3,
    ),

    dividerTheme: DividerThemeData(
      color: isDark ? AppColors.gray800 : AppColors.slate200,
      thickness: 0.8,
      space: 0,
    ),

    listTileTheme: ListTileThemeData(
      subtitleTextStyle: TextStyle(
        fontFamily: kFontFamily,
        color: subtitle,
        fontSize: 13.5,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      color: isDark ? AppColors.gray900 : Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(
          color: isDark ? AppColors.gray800 : AppColors.slate200,
        ),
      ),
      margin: EdgeInsets.zero,
    ),

    // Inputs match the web client: a slate-50 / gray-950 fill inside a subtle
    // border, with the brand colour on focus.
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? AppColors.gray950 : AppColors.slate50,
      labelStyle: TextStyle(color: subtitle, fontWeight: FontWeight.w500),
      floatingLabelStyle: TextStyle(
        color: isDark ? AppColors.primaryDark : AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: TextStyle(color: isDark ? AppColors.slate700 : AppColors.slate400),
      helperStyle: TextStyle(color: subtitle, fontSize: 11.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(
          color: isDark ? AppColors.gray800 : AppColors.slate200,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(
          color: isDark ? AppColors.gray800 : AppColors.slate200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(
          color: isDark ? AppColors.primaryDark : AppColors.primary,
          width: 1.6,
        ),
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: isDark ? AppColors.gray900 : Colors.white,
      surfaceTintColor: Colors.transparent,
      indicatorColor: (isDark ? AppColors.primaryDark : AppColors.primary)
          .withValues(alpha: 0.14),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          fontFamily: kFontFamily,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),

    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: isDark ? AppColors.gray900 : Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
    ),

    textTheme: _textTheme(onSurface, subtitle),
  );
}

/// Inter's weights, matching the web client's usage (600/700 for headings,
/// 500 for labels, 400 for body).
TextTheme _textTheme(Color onSurface, Color subtitle) {
  return TextTheme(
    titleLarge: TextStyle(
      fontFamily: kFontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: onSurface,
    ),
    titleMedium: TextStyle(
      fontFamily: kFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: onSurface,
    ),
    bodyMedium: TextStyle(
      fontFamily: kFontFamily,
      fontSize: 14,
      color: onSurface,
    ),
    bodySmall: TextStyle(
      fontFamily: kFontFamily,
      color: subtitle,
      fontSize: 12.5,
    ),
    labelLarge: TextStyle(
      fontFamily: kFontFamily,
      fontSize: 13.5,
      fontWeight: FontWeight.w600,
      color: onSurface,
    ),
  );
}
