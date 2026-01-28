import 'package:channels/features/my_ads/data/data_sources/my_ads_remote_data_source.dart';
import 'package:channels/features/my_ads/domain/entities/my_ad.dart';
import 'package:channels/features/my_ads/domain/repositories/my_ads_repository.dart';

class MyAdsRepositoryImpl implements MyAdsRepository {
  final MyAdsRemoteDataSource remoteDataSource;

  MyAdsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(List<MyAd>, String, String)> getMyAds() async {
    final response = await remoteDataSource.getMyAds();
    return (response.ads, response.title, response.subTitle);
  }
}
