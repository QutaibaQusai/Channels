import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/create_ad/data/models/filter_model.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';

class FiltersResponseModel {
  final String categoryId;
  final String lang;
  final List<Filter> filters;

  const FiltersResponseModel({
    required this.categoryId,
    required this.lang,
    required this.filters,
  });

  factory FiltersResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> filtersJson =
        (json[ApiKey.filters] as List<dynamic>? ?? <dynamic>[]);

    return FiltersResponseModel(
      categoryId: (json['category_id'] ?? '') as String,
      lang: (json[ApiKey.lang] ?? '') as String,
      filters: filtersJson
          .map((item) => FilterModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
