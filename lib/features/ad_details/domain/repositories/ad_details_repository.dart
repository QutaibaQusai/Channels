import 'package:channels/features/ad_details/domain/entities/ad_details.dart';

/// Repository interface for ad details operations
abstract class AdDetailsRepository {
  /// Fetches ad details by ID
  Future<AdDetails> getAdDetails({
    required String adId,
    required String languageCode,
  });

  /// Deletes an ad by ID
  Future<void> deleteAd({required String adId});
}
