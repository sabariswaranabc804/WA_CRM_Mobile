import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

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
      elevation: 3,
      indicatorColor: (isDark ? AppColors.primaryDark : AppColors.primary)
          .withValues(alpha: 0.16),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: isDark ? AppColors.primaryDark : AppColors.primary,
          );
        }
        return IconThemeData(color: subtitle);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontFamily: kFontFamily,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.primaryDark : AppColors.primary,
          );
        }
        return TextStyle(
          fontFamily: kFontFamily,
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: subtitle,
        );
      }),
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
  );
}
