import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/ads/domain/entities/ad.dart';

/// Ad model - data layer
class AdModel extends Ad {
  const AdModel({
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
    required super.reportCount,
    required super.createdAt,
    required super.phoneE164,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
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
          : {},
      amount:
          ((json[ApiKey.amount] is num)
                  ? (json[ApiKey.amount] as num).toDouble()
                  : double.tryParse(json[ApiKey.amount].toString()) ?? 0.0)
              .toInt(),
      priceCurrency: json[ApiKey.priceCurrency] as String? ?? '',
      status: json[ApiKey.adStatus] as String,
      reportCount: int.tryParse(json[ApiKey.reportCount].toString()) ?? 0,
      createdAt: DateTime.parse(json[ApiKey.createdAt] as String),
      phoneE164: json[ApiKey.phoneE164] as String,
    );
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
      ApiKey.reportCount: reportCount.toString(),
      ApiKey.createdAt: createdAt.toIso8601String(),
      ApiKey.phoneE164: phoneE164,
    };
  }
}
