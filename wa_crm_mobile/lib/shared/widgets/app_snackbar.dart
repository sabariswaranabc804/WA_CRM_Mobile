import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

void showAppSnack(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.dangerStrong : null,
      ),
    );
}
