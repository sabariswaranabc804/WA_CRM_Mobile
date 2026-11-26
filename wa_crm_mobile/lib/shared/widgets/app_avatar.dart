import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/formatters.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final int id;
  final double radius;

  const AppAvatar({
    super.key,
    required this.name,
    required this.id,
    this.radius = AppSizes.avatarMd,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: avatarColorFor(id),
      child: Text(
        initialsFor(name),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: radius * 0.72,
        ),
      ),
    );
  }
}
