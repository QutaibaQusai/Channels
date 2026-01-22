import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/core/api/dio_consumer.dart';
import 'package:channels/core/shared/widgets/loading_widget.dart';
import 'package:channels/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:channels/features/authentication/presentation/views/phone_auth_view.dart';
import 'package:channels/features/authentication/presentation/views/otp_verification/otp_verification_view.dart';
import 'package:channels/features/authentication/presentation/views/country_picker/country_picker_view.dart';
import 'package:channels/features/authentication/presentation/views/register/register_view.dart';
import 'package:channels/features/layout/presentation/views/main_layout.dart';
import 'package:channels/features/authentication/data/data_sources/countries_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/otp_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/verify_otp_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/update_preferences_remote_data_source.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/otp/otp_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/otp_verification/otp_verification_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_cubit.dart';

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
          body: LoadingWidget(),
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
        builder: (context, state) {
          return BlocProvider(
            create: (context) => OtpCubit(
              otpRemoteDataSource: OtpRemoteDataSourceImpl(
                apiConsumer: DioConsumer(dio: Dio()),
              ),
            ),
            child: const PhoneAuthView(),
          );
        },
      ),

      GoRoute(
        path: RouteNames.countryPicker,
        name: RouteNames.countryPicker,
        builder: (context, state) {
          // Get current locale from context
          final locale = Localizations.localeOf(context);
          final languageCode = locale.languageCode;

          return BlocProvider(
            create: (context) => CountriesCubit(
              countriesRemoteDataSource: CountriesRemoteDataSourceImpl(
                apiConsumer: DioConsumer(dio: Dio()),
              ),
              languageCode: languageCode,
            ),
            child: const CountryPickerView(),
          );
        },
      ),

      GoRoute(
        path: RouteNames.otpVerification,
        name: RouteNames.otpVerification,
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) => OtpVerificationCubit(
              verifyOtpRemoteDataSource: VerifyOtpRemoteDataSourceImpl(
                apiConsumer: DioConsumer(dio: Dio()),
              ),
              otpRemoteDataSource: OtpRemoteDataSourceImpl(
                apiConsumer: DioConsumer(dio: Dio()),
              ),
            ),
            child: OtpVerificationView(phoneNumber: phoneNumber),
          );
        },
      ),

      GoRoute(
        path: RouteNames.register,
        name: RouteNames.register,
        builder: (context, state) {
          final token = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) => RegisterCubit(
              updatePreferencesRemoteDataSource:
                  UpdatePreferencesRemoteDataSourceImpl(
                apiConsumer: DioConsumer(dio: Dio()),
              ),
            ),
            child: RegisterView(token: token),
          );
        },
      ),

      // ==================== MAIN APP ====================
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const MainLayout(),
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
