import 'package:channels/features/ad_details/domain/repositories/ad_details_repository.dart';

/// Use case for deleting an ad
class DeleteAd {
  final AdDetailsRepository repository;

  DeleteAd({required this.repository});

  Future<void> call({required String adId}) async {
    return await repository.deleteAd(adId: adId);
  }
}
