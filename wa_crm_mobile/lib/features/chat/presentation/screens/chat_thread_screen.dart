import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/features/chat/data/chat_repository.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_conversation.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_message.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_params.dart';
import 'package:wa_crm_mobile/features/chat/presentation/controllers/chat_controller.dart';
import 'package:wa_crm_mobile/features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:wa_crm_mobile/features/chat/presentation/widgets/template_picker_sheet.dart';
import 'package:wa_crm_mobile/shared/widgets/widgets.dart';

class ChatThreadScreen extends ConsumerStatefulWidget {
  final ChatConversation conversation;

  const ChatThreadScreen({super.key, required this.conversation});

  @override
  ConsumerState<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends ConsumerState<ChatThreadScreen> {
  static const _pollInterval = Duration(seconds: 10);
  final _scrollController = ScrollController();
  final _composerController = TextEditingController();

  late ChatConversation _conversation;
  List<ChatMessage> _messages = [];
  bool _loading = true;
  bool _loadingOlder = false;
  bool _sending = false;
  int _page = 1;
  int _totalPages = 1;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _conversation = widget.conversation;
    _scrollController.addListener(_onScroll);
    _loadMessages();
    _startPolling();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _scrollController.dispose();
    _composerController.dispose();
    super.dispose();
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) => _pollNewMessages());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadOlderMessages();
    }
  }

  Future<void> _loadMessages() async {
    setState(() {
      _loading = true;
    });

    try {
      final repo = ref.read(chatRepositoryProvider);
      final response = await repo.listMessages(
        ListMessagesParams(conversationId: _conversation.id, page: 1, limit: 50),
      );
      final fresh = await repo.getConversation(_conversation.id);

      if (!mounted) return;
      setState(() {
        _messages = response.data;
        _page = response.pagination?.page ?? 1;
        _totalPages = response.pagination?.totalPages ?? 1;
        _conversation = fresh;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _loadOlderMessages() async {
    if (_loadingOlder || _loading || _page >= _totalPages) return;

    setState(() => _loadingOlder = true);

    try {
      final repo = ref.read(chatRepositoryProvider);
      final response = await repo.listMessages(
        ListMessagesParams(
          conversationId: _conversation.id,
          page: _page + 1,
          limit: 50,
        ),
      );

      if (!mounted) return;
      final existingIds = _messages.map((m) => m.id).toSet();
      final older = response.data.where((m) => !existingIds.contains(m.id)).toList();

      setState(() {
        _messages.addAll(older);
        _page = response.pagination?.page ?? (_page + 1);
        _totalPages = response.pagination?.totalPages ?? _totalPages;
        _loadingOlder = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loadingOlder = false);
    }
  }

  Future<void> _pollNewMessages() async {
    if (!mounted || _loading) return;
    try {
      final repo = ref.read(chatRepositoryProvider);
      final response = await repo.listMessages(
        ListMessagesParams(conversationId: _conversation.id, page: 1, limit: 50),
      );
      if (!mounted) return;

      final existingMap = {for (final m in _messages) m.id: m};
      final newItems =
          response.data.where((m) => !existingMap.containsKey(m.id)).toList();

      if (newItems.isNotEmpty) {
        setState(() {
          _messages = [...newItems, ..._messages];
        });
        repo.markRead(_conversation.id);
      }
    } catch (_) {}
  }

  Future<void> _sendMessage() async {
    final text = _composerController.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    _composerController.clear();

    try {
      final repo = ref.read(chatRepositoryProvider);
      await repo.sendReply(
        SendReplyParams(conversationId: _conversation.id, body: text),
      );

      await _pollNewMessages();
    } catch (e) {
      if (mounted) showAppSnack(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _pickAndSendTemplate() async {
    final templateId = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TemplatePickerSheet(),
    );

    if (templateId == null || !mounted) return;

    setState(() => _sending = true);
    try {
      final repo = ref.read(chatRepositoryProvider);
      await repo.sendReply(
        SendReplyParams(
          conversationId: _conversation.id,
          templateId: templateId,
        ),
      );
      if (!mounted) return;
      showAppSnack(context, 'Template message sent successfully');
      await _pollNewMessages();
    } catch (e) {
      if (mounted) showAppSnack(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.chatBackground(context),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            AppAvatar(
              name: _conversation.title,
              id: _conversation.id,
              radius: 18,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _conversation.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _conversation.contactPhone ?? 'WhatsApp Customer',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.subtitle(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (val) async {
              if (val == 'close') {
                await ref
                    .read(chatControllerProvider.notifier)
                    .closeConversation(_conversation.id);
                if (context.mounted) {
                  showAppSnack(context, 'Conversation closed');
                  Navigator.of(context).pop();
                }
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'close',
                child: Text('Close Conversation'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (!_conversation.withinSessionWindow) _sessionWindowBanner(context),
            Expanded(
              child: _loading
                  ? const Center(child: AppLoader())
                  : _messages.isEmpty
                      ? Center(
                          child: Text(
                            'No messages in this conversation yet.',
                            style: TextStyle(color: AppColors.subtitle(context)),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          itemCount: _messages.length + (_loadingOlder ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= _messages.length) {
                              return const Padding(
                                padding: EdgeInsets.all(AppSpacing.md),
                                child: Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return ChatMessageBubble(
                              message: _messages[index],
                            );
                          },
                        ),
            ),
            _buildComposer(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _sessionWindowBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      color: AppColors.warning.withValues(alpha: 0.12),
      child: Row(
        children: [
          const Icon(
            Icons.access_time_filled_rounded,
            color: AppColors.warning,
            size: 18,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '24h WhatsApp session window closed.',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          TextButton(
            onPressed: _pickAndSendTemplate,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              visualDensity: VisualDensity.compact,
            ),
            child:  Text(
              'Use Template',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        border: Border(
          top: BorderSide(
            color: AppColors.border(context),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Templates',
            icon:  Icon(
              Icons.bookmark_border_rounded,
              color: AppColors.secondary500,
            ),
            onPressed: _pickAndSendTemplate,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: isDark ? AppColors.gray950 : AppColors.slate50,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: TextField(
                controller: _composerController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.subtitle(context),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 4),
          IconButton.filled(
            tooltip: 'Send',
            icon: _sending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.send_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary500,
              foregroundColor: Colors.white,
            ),
            onPressed: _sending ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
