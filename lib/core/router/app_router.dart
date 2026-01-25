import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:channels/features/authentication/presentation/views/phone_auth/phone_auth_view.dart';
import 'package:channels/features/authentication/presentation/views/otp_verification/otp_verification_view.dart';
import 'package:channels/features/authentication/presentation/views/country_picker/country_picker_view.dart';
import 'package:channels/features/authentication/presentation/views/register/register_view.dart';
import 'package:channels/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:channels/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:channels/features/authentication/domain/usecases/get_countries_usecase.dart';
import 'package:channels/features/authentication/domain/usecases/update_preferences_usecase.dart';
import 'package:channels/features/layout/presentation/views/main_layout.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/otp/otp_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/otp_verification/otp_verification_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_cubit.dart';
import 'package:channels/features/ads/presentation/views/category_ads/category_ads_view.dart';
import 'package:channels/features/ads/presentation/views/ad_details/ad_details_view.dart';
import 'package:channels/features/ads/presentation/cubit/ad_details/ad_details_cubit.dart';
import 'package:channels/features/ads/domain/usecases/get_ad_details.dart';
import 'package:channels/features/profile/presentation/views/profile/profile_view.dart';
import 'package:channels/features/profile/presentation/views/profile_edit/profile_edit_view.dart';
import 'package:channels/features/create_ad/presentation/views/select_category/select_category_view.dart';
import 'package:channels/features/create_ad/presentation/views/select_subcategory/select_subcategory_view.dart';
import 'package:channels/features/create_ad/presentation/views/ad_form/ad_form_view.dart';
import 'package:channels/features/create_ad/presentation/views/upload_images/upload_images_view.dart';
import 'package:channels/features/create_ad/presentation/views/ad_details/ad_details_view.dart';
import 'package:channels/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:channels/features/profile/domain/usecases/get_profile.dart';
import 'package:channels/features/profile/domain/usecases/update_profile.dart';
import 'package:channels/features/notification/presentation/views/notification_view.dart';
import 'package:channels/core/shared/views/webview_page.dart';
import 'package:channels/features/ads/presentation/views/image_viewer/image_viewer_view.dart';

/// Centralized routing configuration using Go Router
class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.onboarding,
    debugLogDiagnostics: true,

    routes: [
      // ==================== ONBOARDING ====================
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),

      // ==================== AUTH ====================
      GoRoute(
        path: RouteNames.phoneAuth,
        name: RouteNames.phoneAuth,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                OtpCubit(requestOtpUseCase: sl<RequestOtpUseCase>()),
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
              getCountriesUseCase: sl<GetCountriesUseCase>(),
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
              verifyOtpUseCase: sl<VerifyOtpUseCase>(),
              requestOtpUseCase: sl<RequestOtpUseCase>(),
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
              updatePreferencesUseCase: sl<UpdatePreferencesUseCase>(),
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
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProfileCubit(
              getProfileUseCase: sl<GetProfile>(),
              updateProfileUseCase: sl<UpdateProfile>(),
            ),
            child: const ProfileView(),
          );
        },
        routes: [
          GoRoute(
            path: 'edit',
            name: RouteNames.profileEdit,
            builder: (context, state) {
              // We expect the parent's ProfileCubit to be passed as extra
              final cubit = state.extra as ProfileCubit;
              return BlocProvider.value(
                value: cubit,
                child: const ProfileEditView(),
              );
            },
          ),
        ],
      ),

      GoRoute(
        path: RouteNames.notification,
        name: RouteNames.notification,
        builder: (context, state) => const NotificationView(),
      ),

      GoRoute(
        path: RouteNames.categoryAds,
        name: RouteNames.categoryAds,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          final categoryId = extra['categoryId'] ?? '';
          final categoryName = extra['categoryName'] ?? '';
          return CategoryAdsView(
            categoryId: categoryId,
            categoryName: categoryName,
          );
        },
      ),

      GoRoute(
        path: RouteNames.adDetails,
        name: RouteNames.adDetails,
        builder: (context, state) {
          final adId = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) =>
                AdDetailsCubit(getAdDetailsUseCase: sl<GetAdDetails>()),
            child: AdDetailsView(adId: adId),
          );
        },
      ),

      GoRoute(
        path: RouteNames.webview,
        name: RouteNames.webview,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          final title = extra['title'] ?? '';
          final url = extra['url'] ?? '';
          return WebViewPage(title: title, url: url);
        },
      ),

      GoRoute(
        path: RouteNames.imageViewer,
        name: RouteNames.imageViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final images = extra['images'] as List<String>? ?? [];
          final initialIndex = extra['initialIndex'] as int? ?? 0;
          return ImageViewerView(images: images, initialIndex: initialIndex);
        },
      ),

      GoRoute(
        path: RouteNames.createAd,
        name: RouteNames.createAd,
        builder: (context, state) => const SelectCategoryView(),
      ),

      GoRoute(
        path: RouteNames.selectSubcategory,
        name: RouteNames.selectSubcategory,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          final categoryId = extra['categoryId'] ?? '';
          final categoryName = extra['categoryName'] ?? '';
          final parentCategoryId = extra['parentCategoryId'] ?? categoryId;
          return SelectSubcategoryView(
            categoryId: categoryId,
            categoryName: categoryName,
            parentCategoryId: parentCategoryId,
          );
        },
      ),

      GoRoute(
        path: RouteNames.adForm,
        name: RouteNames.adForm,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          final categoryId = extra['categoryId'] ?? '';
          final categoryName = extra['categoryName'] ?? '';
          final parentCategoryId = extra['parentCategoryId'] ?? categoryId;
          return AdFormView(
            categoryId: categoryId,
            categoryName: categoryName,
            parentCategoryId: parentCategoryId,
          );
        },
      ),

      GoRoute(
        path: RouteNames.uploadImages,
        name: RouteNames.uploadImages,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final formData = extra['formData'] as Map<String, dynamic>;
          final categoryId = extra['categoryId'] as String;
          return UploadImagesView(formData: formData, categoryId: categoryId);
        },
      ),

      GoRoute(
        path: RouteNames.createAdDetails,
        name: RouteNames.createAdDetails,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final formData = extra['formData'] as Map<String, dynamic>;
          final categoryId = extra['categoryId'] as String;
          final images = extra['images'] as List<File>;
          return CreateAdDetailsView(
            formData: formData,
            categoryId: categoryId,
            images: images,
          );
        },
      ),
    ],

    // ==================== ERROR HANDLING ====================
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.path}')),
    ),
  );
}
