import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_conversation.dart';

part 'chat_controller_state.freezed.dart';

@freezed
abstract class ChatControllerState with _$ChatControllerState {
  const factory ChatControllerState({
    @Default([]) List<ChatConversation> conversations,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? errorMessage,
    @Default('all') String selectedStatus,
    @Default('') String searchQuery,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(0) int totalCount,
    @Default(0) int unreadCount,
  }) = _ChatControllerState;

  factory ChatControllerState.initial() => const ChatControllerState();
}
