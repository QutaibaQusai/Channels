/// Pure business entity representing an onboarding page
/// No dependencies on Flutter or external packages
class OnboardingPage {
  final String title;
  final String subtitle;
  final String imagePath;
  final int index;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.index,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingPage &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.imagePath == imagePath &&
        other.index == index;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        subtitle.hashCode ^
        imagePath.hashCode ^
        index.hashCode;
  }
}
