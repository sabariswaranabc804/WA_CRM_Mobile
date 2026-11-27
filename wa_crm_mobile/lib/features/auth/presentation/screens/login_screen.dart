import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/core/storage/token_storage_provider.dart';
import 'package:wa_crm_mobile/core/utils/validator.dart';
import 'package:wa_crm_mobile/features/auth/domain/models/login_params.dart';
import 'package:wa_crm_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wa_crm_mobile/features/auth/presentation/widgets/login_header.dart';
import 'package:wa_crm_mobile/features/home/presentation/screens/home_shell.dart';
import 'package:wa_crm_mobile/shared/widgets/widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _workspaceController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedLoginHints();
  }

  Future<void> _loadSavedLoginHints() async {
    final storage = ref.read(tokenStorageProvider);
    final savedSlug = await storage.getTenantSlug();
    final savedEmail = await storage.getLastEmail();

    if (!mounted) return;
    if (savedSlug != null && savedSlug.isNotEmpty) {
      _workspaceController.text = savedSlug;
    }
    if (savedEmail != null && savedEmail.isNotEmpty) {
      _emailController.text = savedEmail;
    }
  }

  @override
  void dispose() {
    _workspaceController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    // Prevent duplicate login requests.
    if (ref.read(authControllerProvider).isLoading) return;

    // Validate form inputs.
    if (_formKey.currentState?.validate() != true) return;

    final params = LoginParams(
      workspace: _workspaceController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final success = await ref
        .read(authControllerProvider.notifier)
        .signIn(params);

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // Listen for one-time side effects (e.g. error alerts).
    ref.listen(authControllerProvider, (previous, next) {
      final error = next.errorMessage;

      if (error != null &&
          error.isNotEmpty &&
          error != previous?.errorMessage) {
        showAppSnack(
          context,
          error,
          isError: true,
        );

        ref.read(authControllerProvider.notifier).clearError();
      }
    });

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
                    const LoginHeader(),

                    const SizedBox(height: 36),

                    AppInput(
                      controller: _workspaceController,
                      label: 'Workspace',
                      hint: 'acme-corp',
                      prefixIcon: Icons.business_rounded,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      validator: Validators.workspace,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    AppInput(
                      controller: _emailController,
                      label: 'Email',
                      prefixIcon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      validator: Validators.email,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    AppInput(
                      controller: _passwordController,
                      label: 'Password',
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        if (!authState.isLoading) {
                          _submit();
                        }
                      },
                      validator: Validators.password,
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    AppButton(
                      label: 'Sign In',
                      icon: Icons.login_rounded,
                      size: AppButtonSize.lg,
                      fullWidth: true,
                      isLoading: authState.isLoading,
                      onPressed:
                          authState.isLoading ? null : _submit,
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    Text(
                      AppBrand.tagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.subtitle(context)
                            .withValues(alpha: 0.8),
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
}
