import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';
import 'package:channels/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:channels/features/onboarding/data/datasources/onboarding_local_datasource.dart';

/// Implementation of OnboardingRepository
/// Connects domain layer with data layer
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  List<OnboardingPage> getOnboardingPages() {
    return localDataSource.getOnboardingPages();
  }

  @override
  Future<bool> hasCompletedOnboarding() {
    return localDataSource.hasCompletedOnboarding();
  }

  @override
  Future<void> completeOnboarding() {
    return localDataSource.completeOnboarding();
  }

  @override
  Future<void> resetOnboarding() {
    return localDataSource.resetOnboarding();
  }
}
