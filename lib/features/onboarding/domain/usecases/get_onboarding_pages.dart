import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';
import 'package:channels/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Use case for getting onboarding pages
/// Contains the business logic for fetching onboarding content
class GetOnboardingPages {
  final OnboardingRepository repository;

  GetOnboardingPages(this.repository);

  List<OnboardingPage> call() {
    return repository.getOnboardingPages();
  }
}
