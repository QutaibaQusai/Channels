import 'package:channels/features/categories/domain/entities/category.dart';
import 'package:channels/features/create_ad/domain/repositories/subcategories_repository.dart';
import 'package:channels/features/create_ad/data/data_sources/subcategories_remote_data_source.dart';

class SubcategoriesRepositoryImpl implements SubcategoriesRepository {
  final SubcategoriesRemoteDataSource remoteDataSource;

  SubcategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Category>> getSubcategories({
    required String categoryId,
    required String lang,
  }) async {
    final response = await remoteDataSource.getSubcategories(
      categoryId: categoryId,
      lang: lang,
    );
    return response.subcategories;
  }
}
