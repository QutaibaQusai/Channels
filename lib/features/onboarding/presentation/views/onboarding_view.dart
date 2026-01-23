import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/services/theme_service.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/onboarding/constants/onboarding_data.dart';
import 'package:channels/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:channels/features/onboarding/presentation/widgets/language_toggle_button.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/helpers/spacing.dart';

/// Simple onboarding view with PageView
class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  late PageController _pageController;
  int _currentPage = 0;

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

  Future<void> _completeOnboarding() async {
    final storageService = ref.read(storageServiceProvider);
    await storageService.setBool('onboardingCompleted', true);
    if (mounted) {
      context.go(RouteNames.phoneAuth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Static container with PageView inside
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppSizes.r32),
                      bottomRight: Radius.circular(AppSizes.r32),
                    ),
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: kOnboardingPages.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Image.asset(
                          'assets/images/splash_screen.png',
                          width: 200.w,
                          height: 200.h,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),

              verticalSpace(AppSizes.s24),

              // Text content below
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: _buildTextContent(_currentPage),
                ),
              ),

              // Page indicators
              PageIndicator(
                pageCount: kOnboardingPages.length,
                currentPage: _currentPage,
              ),

              verticalSpace(AppSizes.s40),

              // Next/Get Started button
              _buildBottomButton(l10n),

              verticalSpace(AppSizes.s32),
            ],
          ),

          // Language toggle button
          const LanguageToggleButton(),
        ],
      ),
    );
  }

  Widget _buildTextContent(int pageIndex) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final page = kOnboardingPages[pageIndex];

    String getTranslatedText(String key) {
      switch (key) {
        case 'onboarding.page1.title':
          return l10n.onboardingPage1Title;
        case 'onboarding.page1.subtitle':
          return l10n.onboardingPage1Subtitle;
        case 'onboarding.page2.title':
          return l10n.onboardingPage2Title;
        case 'onboarding.page2.subtitle':
          return l10n.onboardingPage2Subtitle;
        case 'onboarding.page3.title':
          return l10n.onboardingPage3Title;
        case 'onboarding.page3.subtitle':
          return l10n.onboardingPage3Subtitle;
        default:
          return key;
      }
    }

    return Column(
      children: [
        Text(
          getTranslatedText(page.title),
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpace(AppSizes.s12),
        Text(
          getTranslatedText(page.subtitle),
          textAlign: TextAlign.center,
          maxLines: 2,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(AppLocalizations l10n) {
    final isLastPage = _currentPage == kOnboardingPages.length - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
      child: AppButton(
        text: isLastPage ? l10n.commonGetStarted : l10n.commonNext,
        onPressed: () {
          if (isLastPage) {
            _completeOnboarding();
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}
