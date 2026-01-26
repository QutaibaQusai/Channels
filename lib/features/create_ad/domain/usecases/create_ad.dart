import 'dart:io';
import 'package:channels/features/create_ad/domain/repositories/create_ad_repository.dart';

class CreateAd {
  final CreateAdRepository repository;

  CreateAd(this.repository);

  Future<String> call({
    required String categoryId,
    required String subcategoryId,
    required String countryCode,
    required String title,
    required String description,
    required double price,
    required List<File> images,
    required Map<String, dynamic> attributes,
  }) {
    return repository.createAd(
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      countryCode: countryCode,
      title: title,
      description: description,
      price: price,
      images: images,
      attributes: attributes,
    );
  }
}