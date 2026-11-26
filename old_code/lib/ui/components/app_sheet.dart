import 'package:flutter/material.dart';

import '../tokens.dart';

/// The drag handle every bottom sheet starts with.
class AppSheetGrabber extends StatelessWidget {
  const AppSheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(top: AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

/// A bottom sheet sized to its content, lifted above the keyboard.
///
/// Use for forms — anything where the fields should stay put while typing.
class AppFormSheet extends StatelessWidget {
  final String title;
  final Widget child;

  /// Rendered opposite the title, e.g. a delete icon.
  final Widget? trailing;

  const AppFormSheet({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Lift the sheet above the keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppSheetGrabber(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.xxl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ?trailing,
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A draggable, scrollable bottom sheet with a fixed header.
///
/// [builder] receives the sheet's scroll controller and must attach it to the
/// scrollable it returns, otherwise dragging will not work.
///
/// When [changed] is supplied the sheet pops that value on dismiss, which is
/// how the detail sheets tell their list whether to reload.
class AppDraggableSheet extends StatelessWidget {
  final String? title;
  final IconData? titleIcon;
  final double initialSize;
  final double maxSize;
  final Widget Function(BuildContext context, ScrollController controller)
      builder;
  final bool Function()? changed;

  const AppDraggableSheet({
    super.key,
    this.title,
    this.titleIcon,
    this.initialSize = 0.7,
    this.maxSize = 0.92,
    required this.builder,
    this.changed,
  });

  @override
  Widget build(BuildContext context) {
    final sheet = DraggableScrollableSheet(
      expand: false,
      initialChildSize: initialSize,
      maxChildSize: maxSize,
      builder: (context, controller) {
        return Column(
          children: [
            const AppSheetGrabber(),
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    if (titleIcon != null) ...[
                      Icon(titleIcon, size: 20),
                      const SizedBox(width: AppSpacing.md),
                    ],
                    Expanded(
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
            ],
            Expanded(child: builder(context, controller)),
          ],
        );
      },
    );

    if (changed == null) return sheet;

    // Intercept the dismiss so the caller learns whether anything changed.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.pop(context, changed!());
      },
      child: sheet,
    );
  }
}
