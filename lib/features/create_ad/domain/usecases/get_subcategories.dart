import 'package:channels/features/categories/domain/entities/category.dart';
import 'package:channels/features/create_ad/domain/repositories/subcategories_repository.dart';

class GetSubcategories {
  final SubcategoriesRepository repository;

  GetSubcategories(this.repository);

  Future<List<Category>> call({
    required String categoryId,
    required String lang,
  }) {
    return repository.getSubcategories(
      categoryId: categoryId,
      lang: lang,
    );
  }
}
