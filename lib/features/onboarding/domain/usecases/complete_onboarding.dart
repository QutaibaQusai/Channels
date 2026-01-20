import 'package:channels/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Use case for marking onboarding as completed
class CompleteOnboarding {
  final OnboardingRepository repository;

  CompleteOnboarding(this.repository);

  Future<void> call() async {
    await repository.completeOnboarding();
  }
}
