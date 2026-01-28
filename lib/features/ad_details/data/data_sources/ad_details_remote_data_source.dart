import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/ad_details/data/models/ad_details_model.dart';

abstract class AdDetailsRemoteDataSource {
  Future<AdDetailsModel> getAdDetails({
    required String adId,
    required String languageCode,
  });

  Future<void> deleteAd({required String adId});
}

class AdDetailsRemoteDataSourceImpl implements AdDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  AdDetailsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AdDetailsModel> getAdDetails({
    required String adId,
    required String languageCode,
  }) async {
    final response = await apiConsumer.get(
      EndPoint.adDetails(adId),
      data: {'lang': languageCode},
    );

    return AdDetailsModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<void> deleteAd({required String adId}) async {
    await apiConsumer.post(EndPoint.deleteAd(adId));
  }
}
