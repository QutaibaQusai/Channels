import 'package:equatable/equatable.dart';
import 'package:channels/features/categories/domain/entities/category.dart';

class CategoriesResponse extends Equatable {
  final String? parentId;
  final String lang;
  final List<String> heroImages;
  final int count;
  final List<Category> categories;

  const CategoriesResponse({
    required this.lang,
    required this.count,
    required this.categories,
    this.heroImages = const [],
    this.parentId,
  });

  @override
  List<Object?> get props => [parentId, lang, heroImages, count, categories];
}
