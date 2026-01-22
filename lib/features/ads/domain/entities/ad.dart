/// Ad entity - domain layer
class Ad {
  final String id;
  final String userId;
  final String categoryId;
  final String? subcategoryId;
  final String countryCode;
  final String languageCode;
  final String title;
  final String description;
  final List<String> images;
  final Map<String, dynamic> attributes;
  final int amount;
  final String priceCurrency;
  final String status;
  final int reportCount;
  final DateTime createdAt;
  final String phoneE164;

  const Ad({
    required this.id,
    required this.userId,
    required this.categoryId,
    this.subcategoryId,
    required this.countryCode,
    required this.languageCode,
    required this.title,
    required this.description,
    required this.images,
    required this.attributes,
    required this.amount,
    required this.priceCurrency,
    required this.status,
    required this.reportCount,
    required this.createdAt,
    required this.phoneE164,
  });
}
