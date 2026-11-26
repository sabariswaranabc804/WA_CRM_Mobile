import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config.dart';
import '../../state/auth_state.dart';
import '../../state/theme_state.dart';
import '../../ui/ui.dart';
import '../../widgets/server_url_dialog.dart';

/// Profile, workspace and app settings.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthState>();
    final user = auth.user;
    final tenant = auth.tenant;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          if (user != null) _ProfileHeader(name: user.name, email: user.email),
          const SizedBox(height: AppSpacing.sm),
          const AppSectionHeader('Workspace'),
          ListTile(
            leading: const Icon(Icons.business_rounded),
            title: Text(tenant?.name ?? 'Unknown workspace'),
            subtitle: Text(tenant?.slug ?? '—'),
          ),
          if (user != null && user.roles.isNotEmpty)
            ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: const Text('Role'),
              subtitle: Text(user.roles.join(', ')),
            ),
          const Divider(),
          const AppSectionHeader('Appearance'),
          const _ThemeModeSelector(),
          const Divider(),
          const AppSectionHeader('Connection'),
          ListTile(
            leading: const Icon(Icons.dns_outlined),
            title: const Text('Server'),
            subtitle: Text(AppConfig.apiBaseUrl),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showServerUrlDialog(context),
          ),
          const Divider(),
          const AppSectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(AppBrand.name),
            subtitle: Text('Version 1.0.0'),
          ),
          const ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Creating campaigns and templates'),
            subtitle: Text(
              'Authoring happens in the web app. This app is for replying, '
              'managing contacts and tracking what you have sent.',
            ),
            isThreeLine: true,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.xxl,
            ),
            child: AppButton(
              label: 'Log out',
              icon: Icons.logout_rounded,
              variant: AppButtonVariant.dangerOutline,
              fullWidth: true,
              onPressed: () => _confirmLogout(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Log out?',
      message: 'You will need your workspace, email and password to sign '
          'back in.',
      confirmLabel: 'Log out',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;

    await context.read<AuthState>().signOut();
    if (context.mounted) showAppSnack(context, 'Logged out');
  }
}

/// System / Light / Dark, applied immediately and remembered.
class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeState>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ThemeMode>(
              segments: ThemeMode.values
                  .map((mode) => ButtonSegment<ThemeMode>(
                        value: mode,
                        icon: Icon(themeModeIcon(mode), size: 18),
                        label: Text(themeModeLabel(mode)),
                      ))
                  .toList(),
              selected: {theme.mode},
              showSelectedIcon: false,
              onSelectionChanged: (selection) =>
                  context.read<ThemeState>().setMode(selection.first),
              style: SegmentedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
                selectedBackgroundColor: AppColors.accent(context),
                selectedForegroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            theme.mode == ThemeMode.system
                ? 'Following your device setting '
                    '(currently ${theme.isDark(context) ? 'dark' : 'light'}).'
                : '${themeModeLabel(theme.mode)} mode, regardless of your '
                    'device setting.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const _ProfileHeader({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xxl,
        horizontal: AppSpacing.xl,
      ),
      color: isDark
          ? AppColors.gray900
          : AppColors.primary.withValues(alpha: 0.06),
      child: Row(
        children: [
          AppAvatar(name: name, id: name.hashCode, radius: AppSizes.avatarLg),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(email, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
