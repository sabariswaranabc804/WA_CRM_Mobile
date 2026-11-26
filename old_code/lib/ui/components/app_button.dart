import 'package:flutter/material.dart';

import '../tokens.dart';

/// Button variants, matching the React client's `Button` API, plus
/// [dangerOutline] for destructive actions that should not shout — a red
/// outline rather than a solid red fill.
enum AppButtonVariant { primary, secondary, outline, ghost, danger, dangerOutline }

enum AppButtonSize { sm, md, lg }

/// The one button in the app.
///
/// ```dart
/// AppButton(
///   label: 'Log in',
///   onPressed: _submit,
///   isLoading: auth.busy,
///   fullWidth: true,
///   size: AppButtonSize.lg,
/// )
/// ```
///
/// While [isLoading] it disables itself and swaps the label for a spinner, so
/// callers never have to build that combination by hand.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  /// Overrides the label while [isLoading] (e.g. "Sending…").
  final String? loadingLabel;

  /// Fully rounded rather than the default rounded-rect, for hero actions.
  final bool pill;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
    this.loadingLabel,
    this.pill = false,
  });

  double get _height => switch (size) {
        AppButtonSize.sm => AppSizes.buttonSm,
        AppButtonSize.md => AppSizes.buttonMd,
        AppButtonSize.lg => AppSizes.buttonLg,
      };

  double get _fontSize => switch (size) {
        AppButtonSize.sm => 13,
        AppButtonSize.md => 14.5,
        AppButtonSize.lg => 16,
      };

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final foreground = _foregroundColor(context);

    final child = isLoading
        ? _loadingChild(foreground)
        : _labelChild();

    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(fullWidth ? double.infinity : 0, _height),
      ),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: size == AppButtonSize.sm ? 14 : 20),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            pill ? AppRadius.pill : AppRadius.md,
          ),
        ),
      ),
    );

    final button = switch (variant) {
      // The web client's primary button is a primary-600 → 700 gradient with a
      // tinted shadow; Material has no gradient fill, so it is painted behind
      // a transparent button.
      AppButtonVariant.primary => _GradientFill(
          enabled: enabled,
          radius: pill ? AppRadius.pill : AppRadius.md,
          child: FilledButton(
            onPressed: enabled ? onPressed : null,
            style: style.copyWith(
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              shadowColor: const WidgetStatePropertyAll(Colors.transparent),
              elevation: const WidgetStatePropertyAll(0),
            ),
            child: child,
          ),
        ),
      AppButtonVariant.secondary => FilledButton(
          onPressed: enabled ? onPressed : null,
          style: style.copyWith(
            backgroundColor: WidgetStatePropertyAll(AppColors.secondary),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: child,
        ),
      AppButtonVariant.danger => FilledButton(
          onPressed: enabled ? onPressed : null,
          style: style.copyWith(
            backgroundColor:
                const WidgetStatePropertyAll(AppColors.dangerStrong),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          child: child,
        ),
      AppButtonVariant.outline || AppButtonVariant.dangerOutline =>
        OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: style.copyWith(
            foregroundColor: WidgetStatePropertyAll(foreground),
            side: WidgetStatePropertyAll(
              BorderSide(color: foreground.withValues(alpha: 0.45)),
            ),
          ),
          child: child,
        ),
      AppButtonVariant.ghost => TextButton(
          onPressed: enabled ? onPressed : null,
          style: style.copyWith(
            foregroundColor: WidgetStatePropertyAll(foreground),
          ),
          child: child,
        ),
    };

    return fullWidth
        ? SizedBox(width: double.infinity, height: _height, child: button)
        : SizedBox(height: _height, child: button);
  }

  /// Outline and ghost take their colour from the variant's meaning; the
  /// filled variants paint their own foreground white.
  Color _foregroundColor(BuildContext context) => switch (variant) {
        AppButtonVariant.danger || AppButtonVariant.dangerOutline =>
          AppColors.dangerStrong,
        _ => Theme.of(context).colorScheme.primary,
      };

  Widget _labelChild() {
    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: _fontSize + 4),
        const SizedBox(width: AppSpacing.sm),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _loadingChild(Color foreground) {
    final spinnerColor = switch (variant) {
      AppButtonVariant.outline ||
      AppButtonVariant.ghost ||
      AppButtonVariant.dangerOutline =>
        foreground,
      _ => Colors.white,
    };

    final spinner = SizedBox(
      width: _fontSize + 4,
      height: _fontSize + 4,
      child: CircularProgressIndicator(
        strokeWidth: 2.2,
        valueColor: AlwaysStoppedAnimation(spinnerColor),
      ),
    );

    if (loadingLabel == null) return spinner;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        spinner,
        const SizedBox(width: AppSpacing.sm),
        Flexible(child: Text(loadingLabel!, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

/// Paints the brand gradient (and its tinted shadow) behind a button.
class _GradientFill extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final double radius;

  const _GradientFill({
    required this.child,
    required this.enabled,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient(context),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: AppColors.primary500.withValues(alpha: 0.28),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      // A disabled button must still read as disabled through the gradient.
      child: Opacity(opacity: enabled ? 1 : 0.5, child: child),
    );
  }
}
