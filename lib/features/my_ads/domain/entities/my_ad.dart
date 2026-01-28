import 'package:equatable/equatable.dart';

/// Entity representing a user's ad
class MyAd extends Equatable {
  final String id;
  final String userId;
  final String categoryId;
  final String subcategoryId;
  final String countryCode;
  final String languageCode;
  final String title;
  final String description;
  final List<String> images;
  final Map<String, dynamic> attributes;
  final double amount;
  final String priceCurrency;
  final String status; // "active", "inactive", "sold"
  final String approved; // "0" = under review, "1" = approved
  final int reportCount;
  final String createdAt;
  final String phoneE164;
  final String categoryName;
  final String subcategoryName;

  const MyAd({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.subcategoryId,
    required this.countryCode,
    required this.languageCode,
    required this.title,
    required this.description,
    required this.images,
    required this.attributes,
    required this.amount,
    required this.priceCurrency,
    required this.status,
    required this.approved,
    required this.reportCount,
    required this.createdAt,
    required this.phoneE164,
    required this.categoryName,
    required this.subcategoryName,
  });

  /// Helper to check if ad is approved
  bool get isApproved => approved == '1';

  /// Helper to check if ad is under review
  bool get isUnderReview => approved == '0';

  @override
  List<Object?> get props => [
        id,
        userId,
        categoryId,
        subcategoryId,
        countryCode,
        languageCode,
        title,
        description,
        images,
        attributes,
        amount,
        priceCurrency,
        status,
        approved,
        reportCount,
        createdAt,
        phoneE164,
        categoryName,
        subcategoryName,
      ];
}
