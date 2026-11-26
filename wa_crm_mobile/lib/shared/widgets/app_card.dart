import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin = const EdgeInsets.only(bottom: AppSpacing.md),
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.lg);

    return Card(
      margin: margin,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class AppBubble extends StatelessWidget {
  final Widget child;
  final bool outbound;
  final EdgeInsetsGeometry padding;
  final bool shadow;

  const AppBubble({
    super.key,
    required this.child,
    this.outbound = true,
    this.padding = const EdgeInsets.fromLTRB(10, 7, 10, 6),
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: outbound
            ? AppColors.bubbleOut(context)
            : AppColors.bubbleIn(context),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppRadius.md),
          topRight: const Radius.circular(AppRadius.md),
          bottomLeft: Radius.circular(outbound ? AppRadius.md : 2),
          bottomRight: Radius.circular(outbound ? 2 : AppRadius.md),
        ),
        boxShadow: shadow
            ? const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
