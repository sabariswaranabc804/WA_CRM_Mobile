import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/formatters.dart';
import '../../models/conversation.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';
import 'template_picker_sheet.dart';

/// One conversation: the message thread plus the composer.
///
/// Messages arrive newest-first from the API and the list renders with
/// `reverse: true`, so index 0 sits at the bottom and paging up loads older
/// history — the same feel as WhatsApp.
class ChatThreadScreen extends StatefulWidget {
  final Conversation conversation;

  const ChatThreadScreen({super.key, required this.conversation});

  @override
  State<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends State<ChatThreadScreen> {
  static const _pageSize = 50;
  static const _pollInterval = Duration(seconds: 10);

  final _scrollController = ScrollController();
  final _composer = TextEditingController();

  late Conversation _conversation;
  List<Message> _messages = [];
  bool _loading = true;
  bool _loadingMore = false;
  bool _sending = false;
  String? _error;
  int _page = 1;
  int _totalPages = 1;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _conversation = widget.conversation;
    _scrollController.addListener(_onScroll);
    _load();
    _markRead();
    _pollTimer = Timer.periodic(_pollInterval, (_) => _pollNewMessages());
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _scrollController.dispose();
    _composer.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Reversed list: maxScrollExtent is the *oldest* end.
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      _loadOlder();
    }
  }

  // ── Data ─────────────────────────────────────────────────────────────

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final services = context.read<AppServices>();
      final page = await services.inbox.listMessages(
        _conversation.id,
        page: 1,
        limit: _pageSize,
      );
      // Re-read the conversation so the session window and status are current.
      final fresh = await services.inbox.getConversation(_conversation.id);

      if (!mounted) return;
      setState(() {
        _messages = page.items;
        _page = page.page;
        _totalPages = page.totalPages;
        _conversation = fresh;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
      });
    }
  }

  Future<void> _loadOlder() async {
    if (_loadingMore || _loading || _page >= _totalPages) return;
    setState(() => _loadingMore = true);

    try {
      final older = await context.read<AppServices>().inbox.listMessages(
            _conversation.id,
            page: _page + 1,
            limit: _pageSize,
          );
      if (!mounted) return;
      setState(() {
        final seen = _messages.map((m) => m.id).toSet();
        _messages.addAll(older.items.where((m) => !seen.contains(m.id)));
        _page = older.page;
        _totalPages = older.totalPages;
        _loadingMore = false;
      });
    } on ApiException {
      if (!mounted) return;
      setState(() => _loadingMore = false);
    }
  }

  /// Merges anything new at the head without disturbing scroll position.
  Future<void> _pollNewMessages() async {
    if (!mounted || _loading) return;
    try {
      final page = await context.read<AppServices>().inbox.listMessages(
            _conversation.id,
            page: 1,
            limit: _pageSize,
          );
      if (!mounted) return;

      final existingById = {for (final m in _messages) m.id: m};
      final incoming =
          page.items.where((m) => !existingById.containsKey(m.id)).toList();

      // Delivery ticks change without any new message arriving.
      final statusChanged = page.items.any((fresh) {
        final existing = existingById[fresh.id];
        return existing != null && existing.status != fresh.status;
      });

      if (incoming.isEmpty && !statusChanged) return;

      setState(() {
        final byId = {for (final m in page.items) m.id: m};
        _messages = [
          ...incoming,
          ..._messages.map((m) => byId[m.id] ?? m),
        ];
      });

      if (incoming.any((m) => !m.isOutbound)) {
        _markRead();
      }
    } on ApiException {
      // Silent — polling must not interrupt typing.
    }
  }

  Future<void> _markRead() async {
    if (_conversation.unreadCount == 0) return;
    try {
      await context.read<AppServices>().inbox.markRead(_conversation.id);
    } on ApiException {
      // Not worth surfacing; the badge simply stays until the next open.
    }
  }

  // ── Sending ──────────────────────────────────────────────────────────

  Future<void> _sendText() async {
    final text = _composer.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    try {
      await context.read<AppServices>().inbox.reply(_conversation.id, body: text);
      _composer.clear();
      await _pollNewMessages();
    } on ApiException catch (e) {
      if (mounted) showAppSnack(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _sendTemplate() async {
    final template = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const TemplatePickerSheet(),
    );
    if (template == null || !mounted) return;

    setState(() => _sending = true);
    try {
      await context
          .read<AppServices>()
          .inbox
          .reply(_conversation.id, templateId: template);
      await _load();
    } on ApiException catch (e) {
      if (mounted) showAppSnack(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _closeConversation() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Close this conversation?',
      message: 'It moves out of the open list. A new message from the customer '
          'reopens it.',
      confirmLabel: 'Close',
    );
    if (!confirmed || !mounted) return;

    try {
      await context.read<AppServices>().inbox.close(_conversation.id);
      if (mounted) Navigator.pop(context);
    } on ApiException catch (e) {
      if (mounted) showAppSnack(context, e.message, isError: true);
    }
  }

  // ── UI ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBackground(context),
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(child: _messageList()),
          _composerArea(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          AppAvatar(
            name: _conversation.title,
            id: _conversation.contactId,
            radius: AppSizes.avatarSm,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _conversation.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_conversation.contactPhone != null)
                  Text(
                    _conversation.contactPhone!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      height: 1.3,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'refresh') _load();
            if (value == 'close') _closeConversation();
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'refresh', child: Text('Refresh')),
            if (!_conversation.isClosed)
              const PopupMenuItem(
                value: 'close',
                child: Text('Close conversation'),
              ),
          ],
        ),
      ],
    );
  }

  Widget _messageList() {
    if (_loading) return const AppLoader();
    if (_error != null) return AppErrorState(message: _error!, onRetry: _load);
    if (_messages.isEmpty) {
      return const AppEmptyState(
        icon: Icons.chat_bubble_outline_rounded,
        title: 'No messages yet',
        message: 'Messages in this conversation will appear here.',
      );
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.md,
      ),
      itemCount: _messages.length + (_loadingMore ? 1 : 0),
      itemBuilder: (context, i) {
        if (i >= _messages.length) return AppLoader.footer();

        final message = _messages[i];
        // The next index is the older message; a change of date between them
        // is where the day divider belongs.
        final older = i + 1 < _messages.length ? _messages[i + 1] : null;

        return Column(
          children: [
            if (_startsNewDay(message, older) && message.createdAt != null)
              _DayDivider(label: dayDivider(message.createdAt!)),
            MessageBubble(message: message),
          ],
        );
      },
    );
  }

  bool _startsNewDay(Message message, Message? older) {
    final current = message.createdAt;
    if (current == null) return false;
    if (older?.createdAt == null) return true;
    final previous = older!.createdAt!;
    return current.year != previous.year ||
        current.month != previous.month ||
        current.day != previous.day;
  }

  Widget _composerArea(BuildContext context) {
    if (_conversation.isClosed) {
      return _banner(
        const AppNotice(
          icon: Icons.lock_outline_rounded,
          message: 'This conversation is closed. It reopens when the customer '
              'sends a new message.',
        ),
      );
    }

    // Meta rejects free-form replies more than 24h after the last inbound
    // message; only an approved template can reopen the thread.
    if (!_conversation.withinSessionWindow) {
      return _banner(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppNotice(
              icon: Icons.schedule_rounded,
              iconColor: AppColors.warning,
              message: 'The 24-hour reply window has closed.',
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: 'Send a template',
              icon: Icons.description_outlined,
              fullWidth: true,
              isLoading: _sending,
              loadingLabel: 'Sending…',
              onPressed: _sendTemplate,
            ),
          ],
        ),
      );
    }

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        color: AppColors.chatBackground(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(AppRadius.xl + 4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _composer,
                        minLines: 1,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg + 2,
                            vertical: AppSpacing.md,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.description_outlined, size: 21),
                      tooltip: 'Send a template',
                      onPressed: _sending ? null : _sendTemplate,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs + 2),
            SizedBox(
              width: 48,
              height: 48,
              child: FloatingActionButton(
                onPressed: _sending ? null : _sendText,
                elevation: 1,
                child: _sending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Icon(Icons.send_rounded, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The strip that replaces the composer when sending is restricted.
  Widget _banner(Widget child) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        color: AppColors.surface(context),
        child: child,
      ),
    );
  }
}

class _DayDivider extends StatelessWidget {
  final String label;

  const _DayDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: AppColors.subtitle(context),
          ),
        ),
      ),
    );
  }
}

/// A single message, aligned and coloured by direction.
class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final outbound = message.isOutbound;
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Align(
      alignment: outbound ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
        child: AppBubble(
          outbound: outbound,
          shadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.displayBody,
                style: TextStyle(fontSize: 15, height: 1.32, color: textColor),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    bubbleTime(message.createdAt),
                    style: TextStyle(
                      fontSize: 10.5,
                      color: textColor.withValues(alpha: 0.55),
                    ),
                  ),
                  if (outbound) ...[
                    const SizedBox(width: AppSpacing.xs),
                    MessageStatusTicks(status: message.status),
                  ],
                ],
              ),
              if (message.hasFailed && message.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Text(
                    message.errorMessage!,
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: AppColors.danger,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// WhatsApp's delivery ticks.
class MessageStatusTicks extends StatelessWidget {
  final String status;

  const MessageStatusTicks({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'queued' => const Icon(Icons.schedule, size: 13, color: Colors.black38),
      'sent' => const Icon(Icons.done, size: 14, color: Colors.black45),
      'delivered' =>
        const Icon(Icons.done_all, size: 15, color: Colors.black45),
      'read' => const Icon(Icons.done_all, size: 15, color: AppColors.tick),
      'failed' =>
        const Icon(Icons.error_outline, size: 13, color: AppColors.danger),
      _ => const SizedBox.shrink(),
    };
  }
}
