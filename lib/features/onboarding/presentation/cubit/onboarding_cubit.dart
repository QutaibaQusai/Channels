import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:channels/features/onboarding/domain/usecases/get_onboarding_pages.dart';
import 'package:channels/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:channels/features/onboarding/presentation/cubit/onboarding_state.dart';

/// Cubit for managing onboarding state and logic
class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;
  late final GetOnboardingPages _getOnboardingPages;
  late final CompleteOnboarding _completeOnboarding;

  OnboardingCubit(this.repository) : super(const OnboardingInitial()) {
    _getOnboardingPages = GetOnboardingPages(repository);
    _completeOnboarding = CompleteOnboarding(repository);
    loadOnboardingPages();
  }

  /// Load onboarding pages
  void loadOnboardingPages() {
    try {
      final pages = _getOnboardingPages();
      emit(OnboardingLoaded(pages: pages));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  /// Go to next page
  void nextPage() {
    final currentState = state;
    if (currentState is OnboardingLoaded && !currentState.isLastPage) {
      emit(currentState.copyWith(currentPage: currentState.currentPage + 1));
    }
  }

  /// Go to previous page
  void previousPage() {
    final currentState = state;
    if (currentState is OnboardingLoaded && !currentState.isFirstPage) {
      emit(currentState.copyWith(currentPage: currentState.currentPage - 1));
    }
  }

  /// Set current page (for page controller)
  void setPage(int page) {
    final currentState = state;
    if (currentState is OnboardingLoaded &&
        page >= 0 &&
        page < currentState.pages.length) {
      emit(currentState.copyWith(currentPage: page));
    }
  }

  /// Complete onboarding and navigate to main app
  Future<void> completeOnboarding() async {
    try {
      await _completeOnboarding();
      emit(const OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  /// Skip onboarding
  Future<void> skipOnboarding() async {
    await completeOnboarding();
  }
}
