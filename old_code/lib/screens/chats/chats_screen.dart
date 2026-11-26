import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api_client.dart';
import '../../core/debouncer.dart';
import '../../core/formatters.dart';
import '../../models/conversation.dart';
import '../../state/app_services.dart';
import '../../ui/ui.dart';
import 'chat_thread_screen.dart';
import 'new_chat_screen.dart';

/// The inbox. WhatsApp's chat list, backed by `GET /conversations`.
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
  static const _statuses = ['all', 'open', 'pending', 'closed'];
  static const _pageSize = 30;

  /// The server has no realtime channel yet (`server/src/realtime/` is empty),
  /// so the list polls while the app is in the foreground.
  static const _pollInterval = Duration(seconds: 15);

  final _searchController = TextEditingController();
  final _searchDebounce = Debouncer(kSearchDebounce);

  List<Conversation> _conversations = [];
  String _status = 'all';
  String _search = '';
  bool _searching = false;
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;
  int _page = 1;
  int _totalPages = 1;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
    _startPolling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pollTimer?.cancel();
    _searchDebounce.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startPolling();
      _refreshFirstPage();
    } else {
      _pollTimer?.cancel();
    }
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) => _refreshFirstPage());
  }

  // ── Data ─────────────────────────────────────────────────────────────

  Future<Paged<Conversation>> _fetch(int page) {
    return context.read<AppServices>().inbox.listConversations(
          status: _status,
          search: _search.isEmpty ? null : _search,
          page: page,
          limit: _pageSize,
        );
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final page = await _fetch(1);
      if (!mounted) return;
      setState(() {
        _conversations = page.items;
        _page = page.page;
        _totalPages = page.totalPages;
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

  /// Silent background refresh — never flips the screen back to a spinner.
  Future<void> _refreshFirstPage() async {
    if (!mounted || _loading) return;
    try {
      final page = await _fetch(1);
      if (!mounted) return;
      setState(() {
        // Replacing only the first page would drop later pages; when the user
        // has paged deeper, keep the tail and refresh the head in place.
        if (_page == 1) {
          _conversations = page.items;
        } else {
          final refreshed = {for (final c in page.items) c.id: c};
          _conversations = [
            ...page.items,
            ..._conversations
                .skip(page.items.length)
                .where((c) => !refreshed.containsKey(c.id)),
          ];
        }
        _totalPages = page.totalPages;
        _error = null;
      });
    } on ApiException {
      // A failed poll is not worth interrupting the user over.
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || _loading || _page >= _totalPages) return;
    setState(() => _loadingMore = true);

    try {
      final next = await _fetch(_page + 1);
      if (!mounted) return;
      setState(() {
        final seen = _conversations.map((c) => c.id).toSet();
        _conversations.addAll(next.items.where((c) => !seen.contains(c.id)));
        _page = next.page;
        _totalPages = next.totalPages;
        _loadingMore = false;
      });
    } on ApiException {
      if (!mounted) return;
      setState(() => _loadingMore = false);
    }
  }

  void _onSearchChanged(String value) {
    _searchDebounce.run(() {
      if (!mounted) return;
      setState(() => _search = value.trim());
      _load();
    });
  }

  void _closeSearch() {
    _searchController.clear();
    setState(() {
      _searching = false;
      _search = '';
    });
    _load();
  }

  void _setStatus(String status) {
    if (_status == status) return;
    setState(() => _status = status);
    _load();
  }

  Future<void> _openThread(Conversation conversation) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChatThreadScreen(conversation: conversation),
      ),
    );
    // Unread counts and the last message change while the thread is open.
    _refreshFirstPage();
  }

  Future<void> _startNewChat() async {
    final opened = await Navigator.of(context).push<Conversation>(
      MaterialPageRoute(builder: (_) => const NewChatScreen()),
    );
    if (opened != null && mounted) {
      await _openThread(opened);
    }
  }

  // ── UI ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _searching
          ? AppSearchAppBar(
              controller: _searchController,
              hint: 'Search name or number…',
              onChanged: _onSearchChanged,
              onClose: _closeSearch,
            )
          : AppBar(
              // The wordmark stands in for a title on the primary tab, as the
              // web client's header does.
              title: const AppLogo(height: 26),
              actions: [
                AppSearchAction(
                  tooltip: 'Search chats',
                  onPressed: () => setState(() => _searching = true),
                ),
                AppRefreshAction(onPressed: _load),
              ],
            ),
      body: Column(
        children: [
          AppFilterBar(
            options: _statuses,
            selected: _status,
            onSelected: _setStatus,
          ),
          Expanded(
            child: AppAsyncListView<Conversation>(
              isLoading: _loading,
              error: _error,
              items: _conversations,
              isLoadingMore: _loadingMore,
              onRetry: _load,
              onRefresh: _load,
              onLoadMore: _loadMore,
              separator: const Divider(indent: 84),
              emptyState: AppEmptyState(
                icon: Icons.forum_outlined,
                title: _search.isNotEmpty ? 'No matching chats' : 'No chats yet',
                message: _search.isNotEmpty
                    ? 'Nothing matches "$_search".'
                    : 'Conversations appear here as soon as a customer '
                        'messages your WhatsApp number.',
              ),
              itemBuilder: (context, conversation, _) => ConversationTile(
                conversation: conversation,
                onTap: () => _openThread(conversation),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewChat,
        tooltip: 'New chat',
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

/// One row in the chat list.
class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unread = conversation.unreadCount > 0;
    final subtitleColor = AppColors.subtitle(context);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      leading: AppAvatar(
        name: conversation.title,
        id: conversation.contactId,
        radius: 26,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              conversation.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            chatListTimestamp(conversation.lastMessageAt),
            style: TextStyle(
              fontSize: 12,
              fontWeight: unread ? FontWeight.w600 : FontWeight.w400,
              color: unread ? AppColors.accent(context) : subtitleColor,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          children: [
            Expanded(
              child: Text(
                conversation.preview,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: unread ? FontWeight.w600 : FontWeight.w400,
                  color: subtitleColor,
                ),
              ),
            ),
            if (conversation.isClosed)
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.xs + 2),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 15,
                  color: subtitleColor,
                ),
              ),
            if (unread)
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.xs + 2),
                child: AppCountBadge(count: conversation.unreadCount),
              ),
          ],
        ),
      ),
    );
  }
}
