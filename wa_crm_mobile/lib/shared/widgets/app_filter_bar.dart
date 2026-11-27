import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

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
      color: AppColors.surface(context),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: options.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (_, i) {
            final value = options[i];
            final isSelected = value == selected;

            final selectedBg = isDark
                ? accent.withValues(alpha: 0.22)
                : AppColors.primary50;
            final unselectedBg =
                isDark ? AppColors.gray900 : Colors.white;

            return ChoiceChip(
              label: Text(
                _label(value),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? accent
                      : AppColors.subtitle(context),
                ),
              ),
              selected: isSelected,
              showCheckmark: false,
              backgroundColor: unselectedBg,
              selectedColor: selectedBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                side: BorderSide(
                  color: isSelected
                      ? accent.withValues(alpha: 0.45)
                      : AppColors.border(context),
                  width: 1.0,
                ),
              ),
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 2,
              ),
              onSelected: (_) => onSelected(value),
            );
          },
        ),
      ),
    );
  }
}
