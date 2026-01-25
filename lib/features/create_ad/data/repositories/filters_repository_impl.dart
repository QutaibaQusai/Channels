import 'package:channels/features/create_ad/data/data_sources/filters_remote_data_source.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';
import 'package:channels/features/create_ad/domain/repositories/filters_repository.dart';

class FiltersRepositoryImpl implements FiltersRepository {
  final FiltersRemoteDataSource remoteDataSource;

  FiltersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Filter>> getFilters({
    required String categoryId,
    required String lang,
  }) async {
    final response = await remoteDataSource.getFilters(
      categoryId: categoryId,
      lang: lang,
    );
    return response.filters;
  }
}
