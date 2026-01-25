import 'dart:io';

abstract class CreateAdRepository {
  Future<String> createAd({
    required String categoryId,
    required String subcategoryId,
    required String title,
    required String description,
    required double price,
    required List<File> images,
    required Map<String, dynamic> attributes,
  });
}