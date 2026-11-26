import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_shell.dart';
import 'screens/login_screen.dart';
import 'state/app_services.dart';
import 'state/auth_state.dart';
import 'state/theme_state.dart';
import 'ui/ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final services = AppServices.create();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppServices>.value(value: services),
        ChangeNotifierProvider<AuthState>(
          create: (_) => AuthState(services)..bootstrap(),
        ),
        ChangeNotifierProvider<ThemeState>(
          create: (_) => ThemeState(services.storage)..bootstrap(),
        ),
      ],
      child: const WaCrmApp(),
    ),
  );
}

class WaCrmApp extends StatelessWidget {
  const WaCrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppBrand.name,
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: context.watch<ThemeState>().mode,
      home: const _AuthGate(),
    );
  }
}

/// Chooses the shell based on session status. There is no registration route:
/// tenants sign up on the web, agents only log in here.
class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AuthState>().status;

    return switch (status) {
      AuthStatus.checking => const _SplashScreen(),
      AuthStatus.signedOut => const LoginScreen(),
      AuthStatus.signedIn => const HomeShell(),
    };
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(height: 44),
            const SizedBox(height: AppSpacing.xxl),
            SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                valueColor: AlwaysStoppedAnimation(AppColors.accent(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
