import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/create_ad/data/models/subcategories_response_model.dart';

abstract class SubcategoriesRemoteDataSource {
  Future<SubcategoriesResponseModel> getSubcategories({
    required String categoryId,
    required String lang,
  });
}

class SubcategoriesRemoteDataSourceImpl
    implements SubcategoriesRemoteDataSource {
  final ApiConsumer apiConsumer;

  SubcategoriesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<SubcategoriesResponseModel> getSubcategories({
    required String categoryId,
    required String lang,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.subcategories(categoryId),
      data: {
        ApiKey.lang: lang,
      },
    );

    return SubcategoriesResponseModel.fromJson(
        response as Map<String, dynamic>);
  }
}
