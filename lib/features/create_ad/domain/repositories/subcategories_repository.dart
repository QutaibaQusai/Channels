import 'package:channels/features/create_ad/domain/entities/subcategories_response.dart';

abstract class SubcategoriesRepository {
  Future<SubcategoriesResponse> getSubcategories({
    required String categoryId,
    required String lang,
  });
}
