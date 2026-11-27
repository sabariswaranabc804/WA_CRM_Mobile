import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/core/utils/debouncer.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_conversation.dart';
import 'package:wa_crm_mobile/features/chat/presentation/controllers/chat_controller.dart';
import 'package:wa_crm_mobile/features/chat/presentation/screens/chat_thread_screen.dart';
import 'package:wa_crm_mobile/features/chat/presentation/screens/new_chat_screen.dart';
import 'package:wa_crm_mobile/features/chat/presentation/widgets/chat_tile.dart';
import 'package:wa_crm_mobile/shared/widgets/widgets.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen>
    with WidgetsBindingObserver {
  static const _pollInterval = Duration(seconds: 15);
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(kSearchDebounce);
  Timer? _pollTimer;

  String _selectedFilter = 'all';

  static const List<String> _filterOptions = [
    'all',
    'unassigned',
    'mine',
    'unread',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(_onScroll);
    _startPolling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pollTimer?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startPolling();
      ref.read(chatControllerProvider.notifier).loadConversations(refresh: true);
    } else {
      _pollTimer?.cancel();
    }
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) {
      ref.read(chatControllerProvider.notifier).loadConversations(refresh: false);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(chatControllerProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      ref.read(chatControllerProvider.notifier).search(query.trim());
    });
  }

  void _showWalletSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Workspace Balance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(ctx).colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Available conversation credits for outgoing WhatsApp broadcasts and session messages.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.subtitle(ctx),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.accent(ctx).withValues(alpha: 0.15)
                      : AppColors.primary50,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: AppColors.accent(ctx).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Credits Remaining',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.primary700,
                      ),
                    ),
                    Text(
                      '₹ 2,450.00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.accent(ctx),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = AppColors.accent(context);

    ref.listen(chatControllerProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage &&
          next.errorMessage!.isNotEmpty) {
        showAppSnack(context, next.errorMessage!, isError: true);
        ref.read(chatControllerProvider.notifier).clearError();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.surface(context),
      appBar: AppBar(
        
  surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.surface(context),
        elevation: 0,
        scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
        title: Text(
          'BulkChat',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: accent,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          // Currency / Credits Circle Button
          GestureDetector(
            onTap: () => _showWalletSheet(context),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? AppColors.gray400 : AppColors.slate700,
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '₹',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Camera Button
          IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: 'Camera',
            onPressed: () {
              showAppSnack(context, 'Camera & Media integration ready');
            },
          ),
          // 3-dots Menu
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onSelected: (value) {
              if (value == 'new_chat') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NewChatScreen()),
                );
              } else if (value == 'refresh') {
                ref
                    .read(chatControllerProvider.notifier)
                    .loadConversations(refresh: true);
              } else if (value == 'credits') {
                _showWalletSheet(context);
              } else if (value == 'broadcast') {
                showAppSnack(context, 'Broadcast manager ready');
              }
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: 'new_chat', child: Text('New chat')),
              PopupMenuItem(value: 'broadcast', child: Text('New broadcast')),
              PopupMenuItem(value: 'credits', child: Text('Wallet & Credits')),
              PopupMenuItem(value: 'refresh', child: Text('Refresh chats')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        
      ),
      body: Column(
        children: [
          // Mockup Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xs,
            ),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: isDark ? AppColors.gray800 : AppColors.slate100,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: AppColors.subtitle(context),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      style: TextStyle(
                        fontSize: 14.5,
                        color: isDark ? Colors.white : AppColors.slate900,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ask Meta AI or Search',
                        hintStyle: TextStyle(
                          fontSize: 14.5,
                          color: AppColors.subtitle(context),
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        _onSearchChanged('');
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: AppColors.subtitle(context),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          // Filter Chips
          AppFilterBar(
            options: _filterOptions,
            selected: _selectedFilter,
            labelBuilder: (v) {
              if (v == 'unread') {
                final unread = chatState.unreadCount;
                return unread > 0 ? 'Unread $unread' : 'Unread';
              }
              if (v == 'all') return 'All';
              if (v == 'unassigned') return 'Unassigned';
              if (v == 'mine') return 'Mine';
              return v[0].toUpperCase() + v.substring(1);
            },
            onSelected: (newFilter) {
              setState(() => _selectedFilter = newFilter);
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          Expanded(
            child: _buildBody(context, chatState),
          ),
        ],
      ),
      // Dual Floating Action Buttons matching mockup
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Small Circular Refresh Button
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppColors.gray800 : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => ref
                    .read(chatControllerProvider.notifier)
                    .loadConversations(refresh: true),
                child: Icon(
                  Icons.sync_rounded,
                  size: 20,
                  color: accent,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Main Squircle New Chat Button
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.38),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NewChatScreen()),
                  );
                },
                child: const Icon(
                  Icons.add_comment_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic chatState) {
    if (chatState.isLoading && chatState.conversations.isEmpty) {
      return const Center(child: AppLoader());
    }

    if (chatState.errorMessage != null && chatState.conversations.isEmpty) {
      return AppErrorState(
        message: chatState.errorMessage!,
        onRetry: () => ref
            .read(chatControllerProvider.notifier)
            .loadConversations(refresh: true),
      );
    }

    // Filter conversations based on selected chip
    final allConversations =
        List<ChatConversation>.from(chatState.conversations);

    final filteredList = allConversations.where((c) {
      if (_selectedFilter == 'unassigned') {
        return c.assignedTo == null;
      } else if (_selectedFilter == 'mine') {
        return c.assignedTo != null;
      } else if (_selectedFilter == 'unread') {
        return c.unreadCount > 0;
      }
      return true;
    }).toList();

    if (filteredList.isEmpty) {
      return AppEmptyState(
        icon: Icons.chat_bubble_outline_rounded,
        title: chatState.searchQuery.isNotEmpty
            ? 'No Matching Chats'
            : _selectedFilter != 'all'
                ? 'No ${_selectedFilter[0].toUpperCase()}${_selectedFilter.substring(1)} Chats'
                : 'No Conversations',
        message: chatState.searchQuery.isNotEmpty
            ? 'No conversations found matching "${chatState.searchQuery}"'
            : 'Active customer conversations will appear here in real-time.',
      );
    }

    return RefreshIndicator(
      color: AppColors.accent(context),
      onRefresh: () => ref
          .read(chatControllerProvider.notifier)
          .loadConversations(refresh: true),
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount:
            filteredList.length + (chatState.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => Divider(
          height: 1,
          indent: 76,
          color: AppColors.border(context).withValues(alpha: 0.6),
        ),
        itemBuilder: (context, index) {
          if (index >= filteredList.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          }

          final conversation = filteredList[index];

          return ChatTile(
            conversation: conversation,
            onTap: () {
              ref
                  .read(chatControllerProvider.notifier)
                  .markRead(conversation.id);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ChatThreadScreen(conversation: conversation),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
