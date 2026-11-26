import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final bool plateOnDark;

  const AppLogo({super.key, this.height = 48, this.plateOnDark = true});

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      AppBrand.logoAsset,
      height: height,
      fit: BoxFit.contain,
      semanticLabel: '${AppBrand.name} logo',
    );

    final needsPlate =
        plateOnDark && Theme.of(context).brightness == Brightness.dark;
    if (!needsPlate) return logo;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: height * 0.32,
        vertical: height * 0.24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: logo,
    );
  }
}
