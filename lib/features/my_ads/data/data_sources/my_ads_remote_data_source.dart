import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/my_ads/data/models/my_ads_response_model.dart';

abstract class MyAdsRemoteDataSource {
  Future<MyAdsResponseModel> getMyAds();
}

class MyAdsRemoteDataSourceImpl implements MyAdsRemoteDataSource {
  final ApiConsumer apiConsumer;

  MyAdsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<MyAdsResponseModel> getMyAds() async {
    final response = await apiConsumer.post(
      EndPoint.myAds,
      // lang is automatically added by interceptor
    );

    // Handle both List and Map responses
    if (response is List) {
      // If API returns a list directly, wrap it in the expected structure
      return MyAdsResponseModel.fromJson({
        'ads': response,
        'title': '',
        'sub_title': '',
      });
    } else {
      // If API returns a map, parse it normally
      return MyAdsResponseModel.fromJson(response as Map<String, dynamic>);
    }
  }
}
