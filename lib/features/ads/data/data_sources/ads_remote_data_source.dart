import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/ads/data/models/ad_model.dart';

abstract class AdsRemoteDataSource {
  Future<List<AdModel>> getCategoryAds({
    required String categoryId,
    required String languageCode,
  });
}

class AdsRemoteDataSourceImpl implements AdsRemoteDataSource {
  final ApiConsumer apiConsumer;

  AdsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<AdModel>> getCategoryAds({
    required String categoryId,
    required String languageCode,
  }) async {
    final response = await apiConsumer.get(
      EndPoint.categoryAds(categoryId),
      data: {'lang': languageCode},
    );

    // API returns Map with 'ads' list
    final List<dynamic> adsJson;
    if (response is List) {
      adsJson = response;
    } else {
      adsJson =
          (response as Map<String, dynamic>)['ads'] as List<dynamic>? ?? [];
    }

    return adsJson
        .map((json) => AdModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
