/// Simple onboarding page data model
class OnboardingPageData {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

/// Static onboarding pages data
/// You can easily change the imagePath here when you update images
const kOnboardingPages = [
  OnboardingPageData(
    title: 'onboarding.page1.title',
    subtitle: 'onboarding.page1.subtitle',
    imagePath: '', // TODO: Add image path when ready
  ),
  OnboardingPageData(
    title: 'onboarding.page2.title',
    subtitle: 'onboarding.page2.subtitle',
    imagePath: '', // TODO: Add image path when ready
  ),
  OnboardingPageData(
    title: 'onboarding.page3.title',
    subtitle: 'onboarding.page3.subtitle',
    imagePath: '', // TODO: Add image path when ready
  ),
];
