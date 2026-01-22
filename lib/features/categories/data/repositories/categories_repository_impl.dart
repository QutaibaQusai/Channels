import 'package:channels/features/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:channels/features/categories/domain/entities/categories_response.dart';
import 'package:channels/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CategoriesResponse> getCategories({
    required String lang,
    String? country,
    String? parentId,
  }) {
    return remoteDataSource.getCategories(
      lang: lang,
      country: country,
      parentId: parentId,
    );
  }
}
