import 'package:channels/features/my_ads/domain/entities/my_ad.dart';
import 'package:channels/features/my_ads/domain/repositories/my_ads_repository.dart';

class GetMyAds {
  final MyAdsRepository repository;

  GetMyAds(this.repository);

  Future<(List<MyAd>, String title, String subTitle)> call() async {
    return await repository.getMyAds();
  }
}
