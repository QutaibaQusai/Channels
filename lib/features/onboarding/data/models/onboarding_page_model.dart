import 'package:channels/features/onboarding/domain/entities/onboarding_page.dart';

/// Data model for onboarding page (extends entity)
/// Used for JSON serialization if needed in the future
class OnboardingPageModel extends OnboardingPage {
  const OnboardingPageModel({
    required super.title,
    required super.subtitle,
    required super.imagePath,
    required super.index,
  });

  /// Convert from entity to model
  factory OnboardingPageModel.fromEntity(OnboardingPage entity) {
    return OnboardingPageModel(
      title: entity.title,
      subtitle: entity.subtitle,
      imagePath: entity.imagePath,
      index: entity.index,
    );
  }

  /// Convert from JSON (for future API integration)
  factory OnboardingPageModel.fromJson(Map<String, dynamic> json) {
    return OnboardingPageModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imagePath: json['imagePath'] as String,
      index: json['index'] as int,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imagePath': imagePath,
      'index': index,
    };
  }
}
