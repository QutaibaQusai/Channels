import 'package:channels/features/ads/domain/entities/ad.dart';
import 'package:channels/features/ads/domain/repositories/ads_repository.dart';

/// Get category ads use case - domain layer
class GetCategoryAds {
  final AdsRepository repository;

  GetCategoryAds(this.repository);

  Future<List<Ad>> call({
    required String categoryId,
    required String languageCode,
  }) async {
    return await repository.getCategoryAds(
      categoryId: categoryId,
      languageCode: languageCode,
    );
  }
}
