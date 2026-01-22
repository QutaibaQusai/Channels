import 'package:channels/features/categories/domain/entities/categories_response.dart';

abstract class CategoriesRepository {
  Future<CategoriesResponse> getCategories({
    required String lang,
    String? country,
    String? parentId,
  });
}
