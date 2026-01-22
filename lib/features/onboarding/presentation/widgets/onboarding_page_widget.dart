import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';

/// Individual onboarding page widget
class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    // Map the page title/subtitle keys to actual translations
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
        // Large black container - takes most of the vertical space, no padding
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.primary, // Black container
            ),
            child: Center(
              child: Image.asset(
                'assets/images/splash_screen.png',
                width: 200.w,
                height: 200.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        verticalSpace(AppSizes.s24),

        // Text content below the container
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                // Title - translated from key
                Text(
                  getTranslatedText(page.title),
                  textAlign: TextAlign.center,
                  style: AppTypography.onboardingTitle,
                ),

                verticalSpace(AppSizes.s12),

                // Subtitle - translated from key
                Text(
                  getTranslatedText(page.subtitle),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: AppTypography.onboardingSubtitle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
