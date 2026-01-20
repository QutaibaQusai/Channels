import 'package:channels/core/services/storage_service.dart';
import 'package:channels/core/constants/storage_keys.dart';
import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';

/// Local data source for onboarding
/// Handles local storage operations
class OnboardingLocalDataSource {
  final StorageService storageService;

  OnboardingLocalDataSource(this.storageService);

  /// Get onboarding pages with translation keys
  /// Titles and subtitles use translation keys that will be translated in the UI
  List<OnboardingPage> getOnboardingPages() {
    return const [
      OnboardingPage(
        title: 'onboarding.page1.title',
        subtitle: 'onboarding.page1.subtitle',
        imagePath: '', // We'll use icon placeholders
        index: 0,
      ),
      OnboardingPage(
        title: 'onboarding.page2.title',
        subtitle: 'onboarding.page2.subtitle',
        imagePath: '',
        index: 1,
      ),
      OnboardingPage(
        title: 'onboarding.page3.title',
        subtitle: 'onboarding.page3.subtitle',
        imagePath: '',
        index: 2,
      ),
    ];
  }

  /// Check if onboarding is completed
  Future<bool> hasCompletedOnboarding() async {
    return storageService.getBool(StorageKeys.onboardingCompleted) ?? false;
  }

  /// Mark onboarding as completed
  Future<void> completeOnboarding() async {
    await storageService.setBool(StorageKeys.onboardingCompleted, true);
  }

  /// Reset onboarding (for testing)
  Future<void> resetOnboarding() async {
    await storageService.remove(StorageKeys.onboardingCompleted);
  }
}
