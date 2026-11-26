import 'package:flutter/material.dart';

import '../../core/formatters.dart';
import '../tokens.dart';

/// Circular initials avatar, coloured deterministically from [id] so it matches
/// the web client and stays stable across sessions.
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
