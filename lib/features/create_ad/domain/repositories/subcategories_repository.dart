import 'package:channels/features/categories/domain/entities/category.dart';

abstract class SubcategoriesRepository {
  Future<List<Category>> getSubcategories({
    required String categoryId,
    required String lang,
  });
}
