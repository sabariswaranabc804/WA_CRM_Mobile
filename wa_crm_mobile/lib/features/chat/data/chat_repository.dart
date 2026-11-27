import 'dart:convert';
import 'dart:developer' as developer;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wa_crm_mobile/core/constants/api_endpoints.dart';
import 'package:wa_crm_mobile/core/network/api_client.dart';
import 'package:wa_crm_mobile/core/network/api_client_provider.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_conversation.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_message.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_pagination.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_params.dart';

part 'chat_repository.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return ChatRepository(apiClient: client);
}

class ChatRepository {
  final ApiClient apiClient;

  ChatRepository({required this.apiClient});

  Future<ConversationsPagedResponse> listConversations(
    ListConversationsParams params,
  ) async {
    final query = <String, dynamic>{
      'channel': params.channel,
      'page': params.page,
      'limit': params.limit,
    };

    if (params.status != 'all') {
      query['status'] = params.status;
    }

    if (params.search != null && params.search!.trim().isNotEmpty) {
      query['search'] = params.search!.trim();
    }

    final response = await apiClient.getApiConnection(
      url: ApiEndpoints.conversations,
      queryParameters: query,
    );

    final Map<String, dynamic> resMap = _toMap(response);

    // If envelope contains data list
    if (resMap.containsKey('data') && resMap['data'] is List) {
      final rawList = resMap['data'] as List;
      final items = <ChatConversation>[];
      for (final item in rawList) {
        if (item is Map) {
          try {
            items.add(ChatConversation.fromJson(Map<String, dynamic>.from(item)));
          } catch (e, st) {
            developer.log(
              'Failed to parse conversation item: $e',
              error: e,
              stackTrace: st,
              name: 'CHAT_REPO',
            );
          }
        }
      }

      final paginationMap = resMap['pagination'];
      final pagination = paginationMap is Map
          ? ChatPagination.fromJson(Map<String, dynamic>.from(paginationMap))
          : ChatPagination(
              page: params.page,
              totalPages: 1,
              total: items.length,
            );

      return ConversationsPagedResponse(
        data: items,
        pagination: pagination,
      );
    }

    // Direct list fallback
    if (response is List) {
      final items = <ChatConversation>[];
      for (final item in response) {
        if (item is Map) {
          try {
            items.add(ChatConversation.fromJson(Map<String, dynamic>.from(item)));
          } catch (e, st) {
            developer.log(
              'Failed to parse conversation item: $e',
              error: e,
              stackTrace: st,
              name: 'CHAT_REPO',
            );
          }
        }
      }
      return ConversationsPagedResponse(
        data: items,
        pagination: ChatPagination(page: params.page, totalPages: 1, total: items.length),
      );
    }

    return const ConversationsPagedResponse();
  }

  Future<ChatConversation> getConversation(int id) async {
    final response = await apiClient.getApiConnection(
      url: ApiEndpoints.conversation(id),
    );

    final resMap = _toMap(response);
    final data = resMap['data'] is Map ? resMap['data'] as Map<String, dynamic> : resMap;

    return ChatConversation.fromJson(data);
  }

  Future<MessagesPagedResponse> listMessages(ListMessagesParams params) async {
    final response = await apiClient.getApiConnection(
      url: ApiEndpoints.conversationMessages(params.conversationId),
      queryParameters: {
        'page': params.page,
        'limit': params.limit,
      },
    );

    final resMap = _toMap(response);

    if (resMap.containsKey('data') && resMap['data'] is List) {
      final rawList = resMap['data'] as List;
      final items = <ChatMessage>[];
      for (final item in rawList) {
        if (item is Map) {
          try {
            items.add(ChatMessage.fromJson(Map<String, dynamic>.from(item)));
          } catch (e, st) {
            developer.log(
              'Failed to parse message item: $e',
              error: e,
              stackTrace: st,
              name: 'CHAT_REPO',
            );
          }
        }
      }

      final paginationMap = resMap['pagination'];
      final pagination = paginationMap is Map
          ? ChatPagination.fromJson(Map<String, dynamic>.from(paginationMap))
          : ChatPagination(
              page: params.page,
              totalPages: 1,
              total: items.length,
            );

      return MessagesPagedResponse(
        data: items,
        pagination: pagination,
      );
    }

    if (response is List) {
      final items = <ChatMessage>[];
      for (final item in response) {
        if (item is Map) {
          try {
            items.add(ChatMessage.fromJson(Map<String, dynamic>.from(item)));
          } catch (e, st) {
            developer.log(
              'Failed to parse message item: $e',
              error: e,
              stackTrace: st,
              name: 'CHAT_REPO',
            );
          }
        }
      }
      return MessagesPagedResponse(
        data: items,
        pagination: ChatPagination(page: params.page, totalPages: 1, total: items.length),
      );
    }

    return const MessagesPagedResponse();
  }

  Future<void> sendReply(SendReplyParams params) async {
    final body = <String, dynamic>{};
    if (params.body != null && params.body!.isNotEmpty) {
      body['body'] = params.body;
    }
    if (params.templateId != null) {
      body['template_id'] = params.templateId;
    }

    await apiClient.postApiConnection(
      url: ApiEndpoints.conversationReply(params.conversationId),
      params: body,
    );
  }

  Future<void> markRead(int conversationId) async {
    try {
      await apiClient.postApiConnection(
        url: ApiEndpoints.conversationRead(conversationId),
        params: const {},
      );
    } catch (_) {}
  }

  Future<void> closeConversation(int conversationId) async {
    await apiClient.postApiConnection(
      url: ApiEndpoints.conversationClose(conversationId),
      params: const {},
    );
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await apiClient.getApiConnection(
        url: ApiEndpoints.unreadCount,
      );
      final resMap = _toMap(response);
      final count = resMap['count'] ?? resMap['data']?['count'];
      return int.tryParse(count.toString()) ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Map<String, dynamic> _toMap(dynamic response) {
    if (response is Map<String, dynamic>) return response;
    if (response is Map) return Map<String, dynamic>.from(response);
    if (response is String && response.trim().startsWith('{')) {
      try {
        return jsonDecode(response) as Map<String, dynamic>;
      } catch (_) {}
    }
    return <String, dynamic>{};
  }
}
