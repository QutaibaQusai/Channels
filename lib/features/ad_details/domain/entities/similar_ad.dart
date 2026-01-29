import 'package:equatable/equatable.dart';

/// Similar Ad entity - simplified version of Ad for similar ads list
class SimilarAd extends Equatable {
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
  final double amount;
  final String priceCurrency;
  final String status;
  final String approved;
  final int reportCount;
  final DateTime createdAt;

  const SimilarAd({
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
    required this.approved,
    required this.reportCount,
    required this.createdAt,
  });

  /// Check if ad has multiple images
  bool get hasMultipleImages => images.length > 1;

  /// Check if ad is approved
  bool get isApproved => approved == '1';

  /// Get formatted price
  String get formattedPrice => '${amount.toStringAsFixed(2)} $priceCurrency';

  /// Get first image or empty string
  String get firstImage => images.isNotEmpty ? images.first : '';

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
  ];
}
