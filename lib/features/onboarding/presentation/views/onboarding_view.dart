import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/services/storage_service.dart';
import 'package:channels/core/services/language_service.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/localization/app_localizations.dart';
import 'package:channels/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:channels/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:channels/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:channels/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:channels/features/onboarding/presentation/widgets/onboarding_page_widget.dart';
import 'package:channels/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:channels/core/theme/app_colors.dart';

/// Main onboarding view with page view
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Get storage service from main.dart
        final storageService = StorageService();
        final dataSource = OnboardingLocalDataSource(storageService);
        final repository = OnboardingRepositoryImpl(dataSource);
        return OnboardingCubit(repository);
      },
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            // Navigate to login/home screen
            context.go('/login');
          }
        },
        builder: (context, state) {
          if (state is OnboardingInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is OnboardingError) {
            return Scaffold(
              body: Center(child: Text('Error: ${state.message}')),
            );
          }

          if (state is OnboardingLoaded) {
            return Scaffold(
              backgroundColor: AppColors.backgroundLight,
              body: Stack(
                children: [
                  // Main content with PageView
                  Column(
                    children: [
                      // Page view
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            context.read<OnboardingCubit>().setPage(index);
                          },
                          itemCount: state.pages.length,
                          itemBuilder: (context, index) {
                            return OnboardingPageWidget(
                              page: state.pages[index],
                            );
                          },
                        ),
                      ),

                      // Page indicators
                      PageIndicator(
                        pageCount: state.pages.length,
                        currentPage: state.currentPage,
                      ),

                      SizedBox(height: 40.h),

                      // Next/Get Started button
                      _buildBottomButton(context, state),

                      SizedBox(height: 32.h),
                    ],
                  ),

                  // Language toggle button positioned on top right
                  _buildTopBar(context, state),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, OnboardingLoaded state) {
    return Positioned(
      top: 0,
      right: 0,
      child: SafeArea(
        top: true,
        bottom: false,
        left: false,
        right: true,
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, right: 16.w),
          child: Consumer(
            builder: (context, ref, child) {
              final currentLocale = ref.watch(localeProvider);
              final isArabic = currentLocale.languageCode == 'ar';

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    // Toggle language using official Flutter approach
                    final newLanguage = isArabic ? 'en' : 'ar';
                    await ref.read(localeProvider.notifier).changeLanguage(newLanguage);
                  },
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5), width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          isArabic ? 'English' : 'العربية',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, OnboardingLoaded state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AppButton(
        text: state.isLastPage
            ? 'common.getStarted'.tr(context)
            : 'common.next'.tr(context),
        onPressed: () {
          if (state.isLastPage) {
            context.read<OnboardingCubit>().completeOnboarding();
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
      ),
    );
  }
}
