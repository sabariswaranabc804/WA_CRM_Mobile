import 'package:flutter/material.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/shared/widgets/app_logo.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
