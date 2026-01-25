import 'dart:io';
import 'package:channels/features/create_ad/data/data_sources/create_ad_remote_data_source.dart';
import 'package:channels/features/create_ad/domain/repositories/create_ad_repository.dart';

class CreateAdRepositoryImpl implements CreateAdRepository {
  final CreateAdRemoteDataSource remoteDataSource;

  CreateAdRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> createAd({
    required String categoryId,
    required String subcategoryId,
    required String title,
    required String description,
    required double price,
    required List<File> images,
    required Map<String, dynamic> attributes,
  }) async {
    final response = await remoteDataSource.createAd(
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      title: title,
      description: description,
      price: price,
      images: images,
      attributes: attributes,
    );
    return response.id;
  }
}