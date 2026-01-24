import 'package:channels/features/ads/domain/entities/ad_details.dart';
import 'package:channels/features/ads/domain/repositories/ads_repository.dart';

/// Use case to get ad details by ID
class GetAdDetails {
  final AdsRepository repository;

  GetAdDetails(this.repository);

  Future<AdDetails> call({
    required String adId,
    required String languageCode,
  }) async {
    return await repository.getAdDetails(
      adId: adId,
      languageCode: languageCode,
    );
  }
}
