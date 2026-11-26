import 'package:flutter/material.dart';

const String kFontFamily = 'Inter';

class AppTypography {
  static const String fontFamily = kFontFamily;

  static const TextStyle titleLarge = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
}
