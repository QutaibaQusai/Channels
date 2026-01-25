import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/categories/data/models/category_model.dart';
import 'package:channels/features/categories/domain/entities/category.dart';

class SubcategoriesResponseModel {
  final String? parentId;
  final String lang;
  final List<String> heroImages;
  final int count;
  final List<Category> subcategories;

  const SubcategoriesResponseModel({
    required this.lang,
    required this.count,
    required this.subcategories,
    this.heroImages = const [],
    this.parentId,
  });

  factory SubcategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoriesJson =
        (json[ApiKey.categories] as List<dynamic>? ?? <dynamic>[]);
    final heroData = json[ApiKey.heroImg];
    final List<String> heroImages = [];
    if (heroData is List) {
      heroImages.addAll(heroData.map((e) => e.toString()));
    } else if (heroData is String) {
      heroImages.add(heroData);
    }

    return SubcategoriesResponseModel(
      parentId: json[ApiKey.parentId] as String?,
      lang: (json[ApiKey.lang] ?? '') as String,
      heroImages: heroImages,
      count: (json[ApiKey.count] as num?)?.toInt() ?? categoriesJson.length,
      subcategories:
          categoriesJson
              .map(
                (item) => CategoryModel.fromJson(item as Map<String, dynamic>),
              )
              .toList()
            ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)),
    );
  }
}
