import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/create_ad/data/models/filters_response_model.dart';
import 'package:channels/features/create_ad/data/models/filter_model.dart';

abstract class FiltersRemoteDataSource {
  Future<FiltersResponseModel> getFilters({
    required String categoryId,
    required String lang,
  });
}

class FiltersRemoteDataSourceImpl implements FiltersRemoteDataSource {
  final ApiConsumer apiConsumer;

  FiltersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<FiltersResponseModel> getFilters({
    required String categoryId,
    required String lang,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.filters(categoryId),
      data: {ApiKey.lang: lang},
    );

    // Handle both object and array responses
    if (response is List) {
      // API returned array directly (empty filters case)
      return FiltersResponseModel(
        categoryId: categoryId,
        lang: lang,
        filters: response
            .map((item) => FilterModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      // API returned object with filters field
      return FiltersResponseModel.fromJson(response as Map<String, dynamic>);
    }
  }
}
