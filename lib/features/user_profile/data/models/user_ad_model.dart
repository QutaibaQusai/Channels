import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/user_profile/domain/entities/user_ad.dart';

/// User Ad model - data layer
class UserAdModel extends UserAd {
  const UserAdModel({
    required super.id,
    required super.userId,
    required super.categoryId,
    super.subcategoryId,
    required super.countryCode,
    required super.languageCode,
    required super.title,
    required super.description,
    required super.images,
    required super.attributes,
    required super.amount,
    required super.priceCurrency,
    required super.status,
    required super.approved,
    required super.reportCount,
    required super.createdAt,
    super.categoryName,
    super.subcategoryName,
  });

  factory UserAdModel.fromJson(Map<String, dynamic> json) {
    return UserAdModel(
      id: json[ApiKey.id] as String,
      userId: json[ApiKey.userId] as String,
      categoryId: json[ApiKey.categoryId] as String,
      subcategoryId: json[ApiKey.subcategoryId] as String?,
      countryCode: json[ApiKey.countryCode] as String,
      languageCode: json[ApiKey.languageCode] as String,
      title: json[ApiKey.title] as String,
      description: json[ApiKey.description] as String,
      images: (json[ApiKey.images] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      attributes: (json[ApiKey.attributes] is Map<String, dynamic>)
          ? json[ApiKey.attributes] as Map<String, dynamic>
          : (json[ApiKey.attributes] is List && (json[ApiKey.attributes] as List).isEmpty)
              ? {}
              : {},
      amount: _parseAmount(json[ApiKey.amount]),
      priceCurrency: json[ApiKey.priceCurrency] as String? ?? '',
      status: json[ApiKey.adStatus] as String,
      approved: (json[ApiKey.approved] ?? '0').toString(),
      reportCount: int.tryParse(json[ApiKey.reportCount].toString()) ?? 0,
      createdAt: DateTime.parse(json[ApiKey.createdAt] as String),
      categoryName: json[ApiKey.categoryName] as String?,
      subcategoryName: json[ApiKey.subcategoryName] as String?,
    );
  }

  /// Parse amount from API (can be String or num)
  static double _parseAmount(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value.toString()) ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.userId: userId,
      ApiKey.categoryId: categoryId,
      ApiKey.subcategoryId: subcategoryId,
      ApiKey.countryCode: countryCode,
      ApiKey.languageCode: languageCode,
      ApiKey.title: title,
      ApiKey.description: description,
      ApiKey.images: images,
      ApiKey.attributes: attributes,
      ApiKey.amount: amount,
      ApiKey.priceCurrency: priceCurrency,
      ApiKey.adStatus: status,
      ApiKey.approved: approved,
      ApiKey.reportCount: reportCount.toString(),
      ApiKey.createdAt: createdAt.toIso8601String(),
      ApiKey.categoryName: categoryName,
      ApiKey.subcategoryName: subcategoryName,
    };
  }
}
