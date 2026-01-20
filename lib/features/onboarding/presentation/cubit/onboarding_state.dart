import 'package:equatable/equatable.dart';
import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';

/// Base state for onboarding
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

/// Initial state - loading onboarding data
class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// Onboarding loaded successfully
class OnboardingLoaded extends OnboardingState {
  final List<OnboardingPage> pages;
  final int currentPage;

  const OnboardingLoaded({
    required this.pages,
    this.currentPage = 0,
  });

  /// Check if current page is last
  bool get isLastPage => currentPage == pages.length - 1;

  /// Check if current page is first
  bool get isFirstPage => currentPage == 0;

  /// Copy with method for state updates
  OnboardingLoaded copyWith({
    List<OnboardingPage>? pages,
    int? currentPage,
  }) {
    return OnboardingLoaded(
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [pages, currentPage];
}

/// Onboarding completed
class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}

/// Onboarding error state
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
