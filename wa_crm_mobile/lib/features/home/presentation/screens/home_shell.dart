import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wa_crm_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:wa_crm_mobile/features/chat/presentation/controllers/chat_controller.dart';
import 'package:wa_crm_mobile/features/chat/presentation/screens/chats_screen.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _currentIndex = 0;

  final List<Widget> _destinations = const [
    ChatsScreen(),
    _PlaceholderTab(
      title: 'Contacts',
      icon: Icons.people_outline_rounded,
      subtitle: 'Manage CRM customer directory and tags',
    ),
    _PlaceholderTab(
      title: 'Campaigns',
      icon: Icons.campaign_outlined,
      subtitle: 'Broadcasts, schedules, and analytics',
    ),
    _PlaceholderTab(
      title: 'Templates',
      icon: Icons.bookmark_border_rounded,
      subtitle: 'Pre-approved WhatsApp Cloud API templates',
    ),
    _PlaceholderTab(
      title: 'Settings',
      icon: Icons.settings_outlined,
      subtitle: 'Workspace preferences, profile, and integrations',
    ),
  ];

  Future<void> _signOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(authControllerProvider.notifier).signOut();
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? null
          : AppBar(
              title: Text(AppBrand.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  tooltip: 'Sign Out',
                  onPressed: _signOut,
                ),
              ],
            ),
      body: IndexedStack(
        index: _currentIndex,
        children: _destinations,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) {
          setState(() => _currentIndex = idx);
        },
        destinations: [
          NavigationDestination(
            icon: Badge(
              isLabelVisible: ref.watch(chatControllerProvider).unreadCount > 0,
              label: Text(
                '${ref.watch(chatControllerProvider).unreadCount}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.accent(context),
              child: const Icon(Icons.chat_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: ref.watch(chatControllerProvider).unreadCount > 0,
              label: Text(
                '${ref.watch(chatControllerProvider).unreadCount}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.accent(context),
              child: const Icon(Icons.chat_rounded),
            ),
            label: 'Chats',
          ),
          const NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge_rounded),
            label: 'Contacts',
          ),
          const NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign_rounded),
            label: 'Campaigns',
          ),
          const NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description_rounded),
            label: 'Templates',
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;

  const _PlaceholderTab({
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 56,
              color: AppColors.accent(context),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
