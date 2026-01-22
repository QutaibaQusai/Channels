import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_ponits.dart';
import 'package:channels/features/categories/data/models/categories_response_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoriesResponseModel> getCategories({
    required String lang,
    String? country,
    String? parentId,
  });
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiConsumer apiConsumer;

  CategoriesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CategoriesResponseModel> getCategories({
    required String lang,
    String? country,
    String? parentId,
  }) async {
    final response = await apiConsumer.get(
      EndPoint.categories,
      queryParameters: {
        ApiKey.lang: lang,
        if (country != null) ApiKey.country: country,
        if (parentId != null) ApiKey.parentId: parentId,
      },
    );

    return CategoriesResponseModel.fromJson(response as Map<String, dynamic>);
  }
}
