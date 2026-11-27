import 'dart:developer' as developer;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wa_crm_mobile/core/network/api_exception.dart';
import 'package:wa_crm_mobile/features/chat/data/chat_repository.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_params.dart';
import 'package:wa_crm_mobile/features/chat/presentation/controllers/chat_controller_state.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  ChatControllerState build() {
    loadConversations();
    return ChatControllerState.initial();
  }

  ChatRepository get _repository => ref.read(chatRepositoryProvider);

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<void> loadConversations({bool refresh = false}) async {
    final page = refresh ? 1 : state.currentPage;

    if (refresh) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    }

    try {
      final response = await _repository.listConversations(
        ListConversationsParams(
          status: state.selectedStatus,
          search: state.searchQuery.isEmpty ? null : state.searchQuery,
          page: page,
          limit: 30,
        ),
      );

      final unread = await _repository.getUnreadCount();

      state = state.copyWith(
        conversations: response.data,
        currentPage: response.pagination?.page ?? 1,
        totalPages: response.pagination?.totalPages ?? 1,
        totalCount: response.pagination?.total ?? response.data.length,
        unreadCount: unread,
        isLoading: false,
        isLoadingMore: false,
        errorMessage: null,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: e.message,
      );
    } catch (e, st) {
      developer.log(
        'Load conversations error: $e',
        error: e,
        stackTrace: st,
        name: 'CHAT_CONTROLLER',
      );
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: 'Unable to load chats. Please pull down to refresh.',
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore ||
        state.isLoading ||
        state.currentPage >= state.totalPages) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _repository.listConversations(
        ListConversationsParams(
          status: state.selectedStatus,
          search: state.searchQuery.isEmpty ? null : state.searchQuery,
          page: nextPage,
          limit: 30,
        ),
      );

      final existingIds = state.conversations.map((c) => c.id).toSet();
      final newItems =
          response.data.where((c) => !existingIds.contains(c.id)).toList();

      state = state.copyWith(
        conversations: [...state.conversations, ...newItems],
        currentPage: response.pagination?.page ?? nextPage,
        totalPages: response.pagination?.totalPages ?? state.totalPages,
        isLoadingMore: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void changeStatus(String status) {
    if (state.selectedStatus == status) return;
    state = state.copyWith(selectedStatus: status, currentPage: 1);
    loadConversations(refresh: true);
  }

  void search(String query) {
    if (state.searchQuery == query) return;
    state = state.copyWith(searchQuery: query, currentPage: 1);
    loadConversations(refresh: true);
  }

  Future<void> markRead(int conversationId) async {
    await _repository.markRead(conversationId);
    state = state.copyWith(
      conversations: state.conversations.map((c) {
        if (c.id == conversationId) {
          return c.copyWith(unreadCount: 0);
        }
        return c;
      }).toList(),
    );
  }

  Future<void> closeConversation(int conversationId) async {
    try {
      await _repository.closeConversation(conversationId);
      state = state.copyWith(
        conversations: state.conversations.map((c) {
          if (c.id == conversationId) {
            return c.copyWith(status: 'closed');
          }
          return c;
        }).toList(),
      );
    } on ApiException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    }
  }
}
