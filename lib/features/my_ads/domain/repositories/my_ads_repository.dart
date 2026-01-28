import 'package:channels/features/my_ads/domain/entities/my_ad.dart';

abstract class MyAdsRepository {
  Future<(List<MyAd>, String title, String subTitle)> getMyAds();
}
