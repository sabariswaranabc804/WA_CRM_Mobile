import 'package:flutter/material.dart';

import '../tokens.dart';

/// The Bulk Chat wordmark, from the same PNG the web client serves at
/// `/logo-bulkchat.png`.
///
/// [height] follows the web usage: `h-12` (48) on the auth screens, smaller in
/// a header.
///
/// The lockup's "Bulk" is dark navy, which all but vanishes on a dark
/// background — the web client has the same problem on its `gray-900` auth
/// card. Rather than tint the mark white (which would throw away the cyan and
/// emerald that carry the brand), dark mode sets it on a white plate. Pass
/// `plateOnDark: false` where the logo already sits on a light surface.
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
      // Named for screen readers, since the mark carries the product name.
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
