import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/config.dart';
import '../state/auth_state.dart';
import '../ui/ui.dart';

/// Lets a tenant point the app at their own server without a rebuild.
///
/// Shared by the login screen and Settings. Applying a new URL clears the
/// session, because tokens are only valid against the server that issued them.
Future<void> showServerUrlDialog(
  BuildContext context, {
  bool allowReset = true,
}) async {
  final result = await showTextPromptDialog(
    context,
    title: 'Server URL',
    initialValue: AppConfig.apiBaseUrl,
    hint: 'http://192.168.1.5:3001/api/v1',
    footnote: 'Default: ${AppConfig.defaultBaseUrl}\n'
        'Changing this logs you out, because your session belongs to the '
        'server that issued it.',
    resetLabel: allowReset ? 'Reset' : null,
    keyboardType: TextInputType.url,
  );

  if (result == null || !context.mounted) return;

  await context.read<AuthState>().changeServerUrl(result);
  if (context.mounted) showAppSnack(context, 'Server URL updated');
}
