import 'package:flutter/material.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/core/utils/formatters.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isOutbound = message.isOutbound;
    final isFailed = message.hasFailed;

    final parsedDate = message.createdAt != null
        ? DateTime.tryParse(message.createdAt!)
        : null;
    final timeStr = bubbleTime(parsedDate);

    final bubbleBg = isOutbound
        ? AppColors.bubbleOut(context)
        : AppColors.bubbleIn(context);

    final textColor = isOutbound
        ? (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : AppColors.slate900)
        : Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
      child: Align(
        alignment: isOutbound ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.78,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              color: bubbleBg,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(AppRadius.lg),
                topRight: const Radius.circular(AppRadius.lg),
                bottomLeft: Radius.circular(isOutbound ? AppRadius.lg : 2),
                bottomRight: Radius.circular(isOutbound ? 2 : AppRadius.lg),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: AppSpacing.md,
              runSpacing: 2,
              children: [
                Text(
                  message.displayBody,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.35,
                    color: textColor,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (timeStr.isNotEmpty)
                      Text(
                        timeStr,
                        style: TextStyle(
                          fontSize: 10.5,
                          color: AppColors.subtitle(context).withValues(alpha: 0.8),
                        ),
                      ),
                    if (isOutbound) ...[
                      const SizedBox(width: 4),
                      _deliveryIcon(context, isFailed),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _deliveryIcon(BuildContext context, bool isFailed) {
    if (isFailed) {
      return const Icon(
        Icons.error_outline_rounded,
        size: 14,
        color: AppColors.danger,
      );
    }

    if (message.isRead) {
      return const Icon(
        Icons.done_all_rounded,
        size: 15,
        color: AppColors.tick,
      );
    }

    if (message.isDelivered) {
      return Icon(
        Icons.done_all_rounded,
        size: 15,
        color: AppColors.subtitle(context),
      );
    }

    return Icon(
      Icons.done_rounded,
      size: 14,
      color: AppColors.subtitle(context),
    );
  }
}
