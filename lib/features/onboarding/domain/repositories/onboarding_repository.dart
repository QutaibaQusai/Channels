import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';

/// Repository interface for onboarding operations
/// This is a contract that the data layer must implement
abstract class OnboardingRepository {
  /// Get list of onboarding pages
  List<OnboardingPage> getOnboardingPages();

  /// Check if user has completed onboarding
  Future<bool> hasCompletedOnboarding();

  /// Mark onboarding as completed
  Future<void> completeOnboarding();

  /// Reset onboarding status (for testing/debug)
  Future<void> resetOnboarding();
}
