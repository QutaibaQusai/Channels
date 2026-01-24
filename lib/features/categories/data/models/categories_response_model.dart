import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/categories/data/models/category_model.dart';
import 'package:channels/features/categories/domain/entities/categories_response.dart';

class CategoriesResponseModel extends CategoriesResponse {
  const CategoriesResponseModel({
    required super.lang,
    required super.count,
    required super.categories,
    super.heroImages = const [],
    super.parentId,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoriesJson =
        (json[ApiKey.categories] as List<dynamic>? ?? <dynamic>[]);
    final heroData = json[ApiKey.heroImg];
    final List<String> heroImages = [];
    if (heroData is List) {
      heroImages.addAll(heroData.map((e) => e.toString()));
    } else if (heroData is String) {
      heroImages.add(heroData);
    }

    return CategoriesResponseModel(
      parentId: json[ApiKey.parentId] as String?,
      lang: (json[ApiKey.lang] ?? '') as String,
      heroImages: heroImages,
      count: (json[ApiKey.count] as num?)?.toInt() ?? categoriesJson.length,
      categories:
          categoriesJson
              .map(
                (item) => CategoryModel.fromJson(item as Map<String, dynamic>),
              )
              .toList()
            ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)),
    );
  }
}
