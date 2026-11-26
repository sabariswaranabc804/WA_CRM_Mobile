import 'package:flutter/material.dart';

import '../ui/ui.dart';
import 'campaigns/campaigns_screen.dart';
import 'chats/chats_screen.dart';
import 'contacts/contacts_screen.dart';
import 'settings/settings_screen.dart';
import 'templates/templates_screen.dart';

/// The signed-in shell: five destinations in a WhatsApp-style bottom bar.
///
/// Each tab is its own Scaffold so it keeps its own app bar, search field and
/// floating action button. Because the outer Scaffold reserves the bottom bar,
/// a tab's FAB lands just above it — the "+" position WhatsApp uses.
///
/// An IndexedStack keeps every tab alive, so switching away and back preserves
/// scroll position and loaded pages instead of refetching.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _tabs = <Widget>[
    ChatsScreen(),
    ContactsScreen(),
    CampaignsScreen(),
    TemplatesScreen(),
    SettingsScreen(),
  ];

  static const _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline_rounded),
      selectedIcon: Icon(Icons.chat_bubble_rounded),
      label: 'Chats',
    ),
    NavigationDestination(
      icon: Icon(Icons.people_outline_rounded),
      selectedIcon: Icon(Icons.people_rounded),
      label: 'Contacts',
    ),
    NavigationDestination(
      icon: Icon(Icons.campaign_outlined),
      selectedIcon: Icon(Icons.campaign_rounded),
      label: 'Campaigns',
    ),
    NavigationDestination(
      icon: Icon(Icons.description_outlined),
      selectedIcon: Icon(Icons.description_rounded),
      label: 'Templates',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings_rounded),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: _destinations,
        height: 64,
        backgroundColor: AppColors.surface(context),
        indicatorColor: AppColors.accent(context).withValues(alpha: 0.16),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }
}
