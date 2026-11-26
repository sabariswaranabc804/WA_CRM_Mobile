import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

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

class AppFormSheet extends StatelessWidget {
  final String title;
  final Widget child;
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.pop(context, changed!());
      },
      child: sheet,
    );
  }
}
