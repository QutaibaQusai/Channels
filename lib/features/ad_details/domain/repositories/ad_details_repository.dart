import 'package:channels/features/ad_details/domain/entities/ad_details.dart';

/// Repository interface for fetching ad details
abstract class AdDetailsRepository {
  /// Fetches ad details by ID
  Future<AdDetails> getAdDetails({
    required String adId,
    required String languageCode,
  });
}
