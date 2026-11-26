import 'package:flutter/material.dart';

import '../tokens.dart';

/// The in-app-bar search field the Chats and Contacts tabs both swap to.
///
/// Pair it with [AppSearchAction] on the normal app bar:
///
/// ```dart
/// appBar: _searching
///     ? AppSearchAppBar(
///         controller: _searchController,
///         hint: 'Search chats…',
///         onChanged: _onSearchChanged,
///         onClose: _closeSearch,
///       )
///     : AppBar(title: const Text('Chats'), actions: [...]),
/// ```
class AppSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onClose;

  const AppSearchAppBar({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.onClose,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Close search',
        onPressed: onClose,
      ),
      title: TextField(
        controller: controller,
        autofocus: true,
        style: TextStyle(
          color: Theme.of(context).appBarTheme.foregroundColor,
          fontSize: 16.5,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColors.accent(context),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.subtitle(context),
            fontWeight: FontWeight.w400,
          ),
          // The app bar already provides the surface; an inset field here
          // would double up on chrome.
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

/// The magnifier that opens search, plus the standard refresh button.
class AppSearchAction extends StatelessWidget {
  final VoidCallback onPressed;
  final String tooltip;

  const AppSearchAction({
    super.key,
    required this.onPressed,
    this.tooltip = 'Search',
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}

class AppRefreshAction extends StatelessWidget {
  final VoidCallback onPressed;

  const AppRefreshAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh),
      tooltip: 'Refresh',
      onPressed: onPressed,
    );
  }
}
