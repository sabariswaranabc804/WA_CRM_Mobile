import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_services.dart';
import '../state/auth_state.dart';
import '../ui/ui.dart';
import '../widgets/server_url_dialog.dart';

/// Agent sign-in.
///
/// Three fields, because `POST /auth/login` needs a tenant slug alongside the
/// credentials — one email can exist in several workspaces. There is no
/// "create account" link on purpose: workspaces are provisioned on the web.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _workspace = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _prefillFromLastLogin();
  }

  Future<void> _prefillFromLastLogin() async {
    final storage = context.read<AppServices>().storage;
    final slug = await storage.readTenantSlug();
    final email = await storage.readLastEmail();
    if (!mounted) return;
    setState(() {
      _workspace.text = slug ?? '';
      _email.text = email ?? '';
    });
  }

  @override
  void dispose() {
    _workspace.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
debugPrint('jwefwef:');
    final auth = context.read<AuthState>();
    final ok = await auth.signIn(
      workspace: _workspace.text,
      email: _email.text,
      password: _password.text,
    );

    if (!ok && mounted) {
      showAppSnack(context, auth.error ?? 'Login failed', isError: true);
      auth.clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthState>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xxl,
              vertical: AppSpacing.xxl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _header(context),
                    const SizedBox(height: 36),
                    AppInput(
                      controller: _workspace,
                      label: 'Workspace',
                      hint: 'acme-corp',
                      helperText: 'The workspace name your admin gave you',
                      prefixIcon: Icons.business_rounded,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Enter your workspace'
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppInput(
                      controller: _email,
                      label: 'Email',
                      prefixIcon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Enter your email';
                        if (!value.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppInput(
                      controller: _password,
                      label: 'Password',
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => auth.busy ? null : _submit(),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Enter your password' : null,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    AppButton(
                      label: 'Sign In',
                      icon: Icons.login_rounded,
                      size: AppButtonSize.lg,
                      fullWidth: true,
                      isLoading: auth.busy,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Accounts are created by your workspace admin.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppButton(
                      label: 'Server settings',
                      icon: Icons.dns_outlined,
                      variant: AppButtonVariant.ghost,
                      size: AppButtonSize.sm,
                      onPressed: () => showServerUrlDialog(context),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      AppBrand.tagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.subtitle(context).withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Mirrors the web client's auth header: logo lockup, "Welcome Back",
  /// then the dashboard subtitle.
  Widget _header(BuildContext context) {
    return Column(
      children: [
        const AppLogo(height: 48),
        const SizedBox(height: AppSpacing.xxl),
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Sign in to your ${AppBrand.name} dashboard',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
