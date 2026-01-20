import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:channels/features/authentication/presentation/views/phone_auth_view.dart';
import 'package:channels/features/authentication/presentation/views/otp_verification_view.dart';

/// Centralized routing configuration using Go Router
class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.onboarding,
    debugLogDiagnostics: true,

    routes: [
      // ==================== SPLASH ====================
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),

      // ==================== ONBOARDING ====================
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),

      // ==================== AUTH ====================
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login Screen')),
        ),
      ),

      GoRoute(
        path: RouteNames.signup,
        name: RouteNames.signup,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Signup Screen')),
        ),
      ),

      GoRoute(
        path: RouteNames.phoneAuth,
        name: RouteNames.phoneAuth,
        builder: (context, state) => const PhoneAuthView(),
      ),

      GoRoute(
        path: RouteNames.otpVerification,
        name: RouteNames.otpVerification,
        builder: (context, state) => const OtpVerificationView(),
      ),

      // ==================== MAIN APP ====================
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen')),
        ),
      ),

      GoRoute(
        path: RouteNames.profile,
        name: RouteNames.profile,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Profile Screen')),
        ),
      ),

      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settings,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings Screen')),
        ),
      ),
    ],

    // ==================== ERROR HANDLING ====================
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}
