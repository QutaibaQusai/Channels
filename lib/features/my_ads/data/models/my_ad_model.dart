import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/my_ads/domain/entities/my_ad.dart';

class MyAdModel extends MyAd {
  const MyAdModel({
    required super.id,
    required super.userId,
    required super.categoryId,
    required super.subcategoryId,
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
    required super.phoneE164,
    required super.categoryName,
    required super.subcategoryName,
  });

  factory MyAdModel.fromJson(Map<String, dynamic> json) {
    return MyAdModel(
      id: json[ApiKey.id] as String,
      userId: json[ApiKey.userId] as String,
      categoryId: json[ApiKey.categoryId] as String,
      subcategoryId: json[ApiKey.subcategoryId] as String,
      countryCode: json[ApiKey.countryCode] as String,
      languageCode: json[ApiKey.languageCode] as String,
      title: json[ApiKey.title] as String,
      description: json[ApiKey.description] as String,
      images:
          (json[ApiKey.images] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      attributes: _parseAttributes(json[ApiKey.attributes]),
      amount: _parseAmount(json[ApiKey.amount]),
      priceCurrency: json[ApiKey.priceCurrency] as String? ?? '',
      status: json[ApiKey.status] as String,
      approved: json[ApiKey.approved] as String,
      reportCount: int.tryParse(json[ApiKey.reportCount].toString()) ?? 0,
      createdAt: json[ApiKey.createdAt] as String,
      phoneE164: json[ApiKey.phoneE164] as String? ?? '',
      categoryName: json[ApiKey.categoryName] as String,
      subcategoryName: json[ApiKey.subcategoryName] as String,
    );
  }

  static Map<String, dynamic> _parseAttributes(dynamic value) {
    // Handle case where API returns empty array [] instead of empty object {}
    if (value is Map<String, dynamic>) {
      return value;
    }
    return {};
  }

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
      ApiKey.status: status,
      ApiKey.approved: approved,
      ApiKey.reportCount: reportCount,
      ApiKey.createdAt: createdAt,
      ApiKey.phoneE164: phoneE164,
      ApiKey.categoryName: categoryName,
      ApiKey.subcategoryName: subcategoryName,
    };
  }
}
