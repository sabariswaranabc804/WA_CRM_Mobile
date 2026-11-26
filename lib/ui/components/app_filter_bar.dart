import 'package:flutter/material.dart';

import '../tokens.dart';

/// The horizontal status-chip strip that sits under an app bar.
///
/// Shared by Chats, Campaigns and Templates — each passes its own vocabulary:
///
/// ```dart
/// AppFilterBar(
///   options: const ['all', 'open', 'pending', 'closed'],
///   selected: _status,
///   onSelected: _setStatus,
/// )
/// ```
///
/// Labels are capitalised from the raw API value by default, so callers keep
/// passing the exact strings the endpoints expect.
class AppFilterBar extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;
  final String Function(String value)? labelBuilder;

  const AppFilterBar({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.labelBuilder,
  });

  String _label(String value) {
    if (labelBuilder != null) return labelBuilder!(value);
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = AppColors.accent(context);

    return Container(
      // Continues the app bar's surface so the chips read as part of the
      // header rather than as a floating strip.
      color: AppColors.surface(context),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: options.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (_, i) {
            final value = options[i];
            final isSelected = value == selected;

            return ChoiceChip(
              label: Text(
                _label(value),
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.subtitle(context),
                ),
              ),
              selected: isSelected,
              showCheckmark: false,
              backgroundColor: isDark ? AppColors.gray800 : AppColors.slate100,
              selectedColor: accent,
              side: BorderSide.none,
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              onSelected: (_) => onSelected(value),
            );
          },
        ),
      ),
    );
  }
}
