import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

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
