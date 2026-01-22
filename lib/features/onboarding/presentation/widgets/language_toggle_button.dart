import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/services/language_service.dart';

/// Language toggle button widget for onboarding
class LanguageToggleButton extends ConsumerWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentLocale = ref.watch(localeProvider);
    final isArabic = currentLocale.languageCode == 'ar';

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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                // Toggle language
                final newLanguage = isArabic ? 'en' : 'ar';
                await ref
                    .read(localeProvider.notifier)
                    .changeLanguage(newLanguage);
              },
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: colorScheme.outline, width: 1),
                ),
                child: Text(
                  isArabic ? '?EN' : 'عربي؟',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
