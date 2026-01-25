import 'dart:io';
import 'package:dio/dio.dart';
import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/create_ad/data/models/create_ad_response_model.dart';

abstract class CreateAdRemoteDataSource {
  Future<CreateAdResponseModel> createAd({
    required String categoryId,
    required String subcategoryId,
    required String title,
    required String description,
    required double price,
    required List<File> images,
    required Map<String, dynamic> attributes,
  });
}

class CreateAdRemoteDataSourceImpl implements CreateAdRemoteDataSource {
  final ApiConsumer apiConsumer;

  CreateAdRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CreateAdResponseModel> createAd({
    required String categoryId,
    required String subcategoryId,
    required String title,
    required String description,
    required double price,
    required List<File> images,
    required Map<String, dynamic> attributes,
  }) async {
    // Prepare form data with multipart for images
    final formData = FormData.fromMap({
      ApiKey.categoryId: categoryId,
      ApiKey.subcategoryId: subcategoryId,
      ApiKey.title: title,
      ApiKey.description: description,
      ApiKey.price: price,
      ApiKey.attributes: attributes,
    });

    // Add images to form data
    for (int i = 0; i < images.length; i++) {
      final file = images[i];
      final fileName = file.path.split('/').last;
      formData.files.add(
        MapEntry(
          '${ApiKey.images}[]',
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        ),
      );
    }

    final response = await apiConsumer.post(
      EndPoint.createAd,
      data: formData,
    );

    return CreateAdResponseModel.fromJson(response as Map<String, dynamic>);
  }
}