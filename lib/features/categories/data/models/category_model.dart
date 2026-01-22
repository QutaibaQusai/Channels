import 'package:channels/core/api/end_ponits.dart';
import 'package:channels/features/categories/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.country,
    required super.sortOrder,
    super.imageUrl,
    super.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json[ApiKey.id] as String,
      parentId: json[ApiKey.parentId] as String?,
      name: json[ApiKey.name] as String,
      country: json[ApiKey.country] as String,
      sortOrder: int.tryParse(json[ApiKey.sortOrder].toString()) ?? 0,
      imageUrl: json[ApiKey.imageUrl] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.parentId: parentId,
      ApiKey.name: name,
      ApiKey.country: country,
      ApiKey.sortOrder: sortOrder,
      ApiKey.imageUrl: imageUrl,
    };
  }
}
