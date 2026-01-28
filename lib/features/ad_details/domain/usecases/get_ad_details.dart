import 'package:channels/features/ad_details/domain/entities/ad_details.dart';
import 'package:channels/features/ad_details/domain/repositories/ad_details_repository.dart';

/// Use case to get ad details by ID
class GetAdDetails {
  final AdDetailsRepository repository;

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
