import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String? parentId;
  final String name;
  final String country;
  final int sortOrder;
  final String? imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.country,
    required this.sortOrder,
    this.parentId,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, parentId, name, country, sortOrder, imageUrl];
}
