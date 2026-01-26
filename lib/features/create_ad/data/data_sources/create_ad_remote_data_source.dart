import 'dart:io';
import 'package:dio/dio.dart';
import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/create_ad/data/models/create_ad_response_model.dart';

abstract class CreateAdRemoteDataSource {
  Future<CreateAdResponseModel> createAd({
    required String categoryId,
    required String subcategoryId,
    required String countryCode,
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
    required String countryCode,
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
      ApiKey.countryCode: countryCode,
      ApiKey.title: title,
      ApiKey.description: description,
      ApiKey.priceAmount: price,
    });

    // Add attributes as individual form fields
    attributes.forEach((key, value) {
      formData.fields.add(MapEntry('${ApiKey.attributes}[$key]', value.toString()));
    });

    // Add images to form data - use same key for multiple files (standard multipart behavior)
    for (int i = 0; i < images.length; i++) {
      final file = images[i];
      final fileName = file.path.split('/').last;
      formData.files.add(
        MapEntry(
          ApiKey.images, // Don't use [] - just repeat the same key
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