import 'package:flutter/material.dart';

import '../tokens.dart';

/// Toast-style feedback. Replaces any in-flight snackbar so a burst of
/// results does not queue up behind the user.
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
