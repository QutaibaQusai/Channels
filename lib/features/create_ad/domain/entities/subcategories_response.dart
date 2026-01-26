import 'package:equatable/equatable.dart';
import 'package:channels/features/categories/domain/entities/category.dart';

class SubcategoriesResponse extends Equatable {
  final String? parentId;
  final String lang;
  final String title;
  final String subTitle;
  final List<String> heroImages;
  final int count;
  final List<Category> subcategories;

  const SubcategoriesResponse({
    required this.lang,
    required this.count,
    required this.subcategories,
    this.title = '',
    this.subTitle = '',
    this.heroImages = const [],
    this.parentId,
  });

  @override
  List<Object?> get props => [
    parentId,
    lang,
    title,
    subTitle,
    heroImages,
    count,
    subcategories,
  ];
}
