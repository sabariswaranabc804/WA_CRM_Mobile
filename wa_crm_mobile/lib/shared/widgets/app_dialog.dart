import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(backgroundColor: AppColors.dangerStrong)
              : null,
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<String?> showTextPromptDialog(
  BuildContext context, {
  required String title,
  String? initialValue,
  String? hint,
  String? footnote,
  String confirmLabel = 'Save',
  String? resetLabel,
  TextInputType? keyboardType,
}) {
  final controller = TextEditingController(text: initialValue);

  return showDialog<String?>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            keyboardType: keyboardType,
            autocorrect: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hint,
            ),
          ),
          if (footnote != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(footnote, style: const TextStyle(fontSize: 11.5)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        if (resetLabel != null)
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, ''),
            child: Text(resetLabel),
          ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, controller.text),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
}
