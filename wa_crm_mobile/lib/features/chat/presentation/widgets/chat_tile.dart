import 'package:flutter/material.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/core/utils/formatters.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_conversation.dart';
import 'package:wa_crm_mobile/shared/widgets/widgets.dart';

class ChatTile extends StatelessWidget {
  final ChatConversation conversation;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final parsedDate = conversation.lastMessageAt != null
        ? DateTime.tryParse(conversation.lastMessageAt!)
        : null;
    final timeStr = chatListTimestamp(parsedDate);

    final hasUnread = conversation.unreadCount > 0;
    final isClosed = conversation.isClosed;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAvatar(
              name: conversation.title,
              id: conversation.id,
              radius: 25,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conversation.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      if (timeStr.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.sm),
                          child: Text(
                            timeStr,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: hasUnread
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: hasUnread
                                  ? AppColors.accent(context)
                                  : AppColors.subtitle(context),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.preview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.normal,
                            color: AppColors.subtitle(context),
                          ),
                        ),
                      ),
                      if (isClosed) ...[
                        const SizedBox(width: AppSpacing.xs),
                        AppBadge.status('closed'),
                      ],
                      if (hasUnread) ...[
                        const SizedBox(width: AppSpacing.xs),
                        AppCountBadge(count: conversation.unreadCount),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
