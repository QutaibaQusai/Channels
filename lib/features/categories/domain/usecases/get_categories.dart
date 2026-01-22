import 'package:channels/features/categories/domain/entities/categories_response.dart';
import 'package:channels/features/categories/domain/repositories/categories_repository.dart';

class GetCategories {
  final CategoriesRepository repository;

  GetCategories(this.repository);

  Future<CategoriesResponse> call({
    required String lang,
    String? country,
    String? parentId,
  }) {
    return repository.getCategories(
      lang: lang,
      country: country,
      parentId: parentId,
    );
  }
}
