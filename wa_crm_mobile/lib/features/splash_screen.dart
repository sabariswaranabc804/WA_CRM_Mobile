import 'package:flutter/material.dart';
import 'package:wa_crm_mobile/core/constants/app_colors.dart';
import 'package:wa_crm_mobile/core/constants/app_spacing.dart';
import 'package:wa_crm_mobile/core/storage/token_storage.dart';
import 'package:wa_crm_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:wa_crm_mobile/features/home/presentation/screens/home_shell.dart';
import 'package:wa_crm_mobile/shared/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TokenStorage _tokenStorage = TokenStorage();

  @override
  void initState() {
    super.initState();
    _bootstrapApp();
  }

  Future<void> _bootstrapApp() async {
    // Wait minimum splash display duration for a smooth experience.
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    // Check if token already exists.
    final token = await _tokenStorage.getAccessToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // Session exists: Route directly to HomeShell.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeShell()),
      );
    } else {
      // No session: Route directly to LoginScreen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(height: 52),
            const SizedBox(height: AppSpacing.xxl),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.accent(context),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              AppBrand.tagline,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.subtitle(context).withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
