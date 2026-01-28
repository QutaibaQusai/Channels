import 'package:channels/features/ads/data/data_sources/ads_remote_data_source.dart';
import 'package:channels/features/ads/domain/entities/ad.dart';
import 'package:channels/features/ads/domain/repositories/ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  final AdsRemoteDataSource remoteDataSource;

  AdsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Ad>> getCategoryAds({
    required String categoryId,
    required String languageCode,
  }) async {
    return await remoteDataSource.getCategoryAds(
      categoryId: categoryId,
      languageCode: languageCode,
    );
  }
}
