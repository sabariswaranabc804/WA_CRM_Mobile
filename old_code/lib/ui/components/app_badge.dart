import 'package:flutter/material.dart';

import '../tokens.dart';

/// Maps a campaign / template / conversation status onto a semantic colour.
/// One place, so "approved" is the same green everywhere it appears.
Color statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'approved':
    case 'completed':
    case 'delivered':
      return AppColors.success;
    case 'sending':
    case 'queued':
    case 'pending':
    case 'scheduled':
      return AppColors.warning;
    case 'rejected':
    case 'failed':
    case 'disabled':
      return AppColors.danger;
    case 'paused':
    case 'cancelled':
      return AppColors.neutral;
    default: // draft, open, …
      return AppColors.info;
  }
}

/// Small outlined pill. Use [AppBadge.status] to colour it from a status
/// string, or pass an explicit [color] for tags and other labels.
class AppBadge extends StatelessWidget {
  final String label;
  final Color color;

  const AppBadge({super.key, required this.label, required this.color});

  /// Colours itself from the status vocabulary.
  AppBadge.status(String status, {super.key})
      : label = status,
        color = statusColor(status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

/// The green unread-count bubble from the chat list.
class AppCountBadge extends StatelessWidget {
  final int count;

  const AppCountBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      constraints: const BoxConstraints(minWidth: 21),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        '$count',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
