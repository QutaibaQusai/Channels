import 'package:channels/features/ads/domain/entities/ad.dart';
import 'package:channels/features/ads/domain/entities/ad_details.dart';

/// Ads repository interface - domain layer
abstract class AdsRepository {
  Future<List<Ad>> getCategoryAds({
    required String categoryId,
    required String languageCode,
  });

  Future<AdDetails> getAdDetails({
    required String adId,
    required String languageCode,
  });
}
