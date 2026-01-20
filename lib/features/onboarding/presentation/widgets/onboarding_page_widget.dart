import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/localization/app_localizations.dart';
import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';

/// Individual onboarding page widget
class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Large black container - takes most of the vertical space, no padding
        Expanded(
          flex: 4,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary, // Black container
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

        SizedBox(height: 24.h),

        // Text content below the container
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                // Title - translated from key
                Text(
                  page.title.tr(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryLight,
                    height: 1.3,
                  ),
                ),

                SizedBox(height: 12.h),

                // Subtitle - translated from key
                Text(
                  page.subtitle.tr(context),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondaryLight,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
