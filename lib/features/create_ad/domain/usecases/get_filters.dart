import 'package:channels/features/create_ad/domain/entities/filter.dart';
import 'package:channels/features/create_ad/domain/repositories/filters_repository.dart';

class GetFilters {
  final FiltersRepository repository;

  GetFilters(this.repository);

  Future<List<Filter>> call({
    required String categoryId,
    required String lang,
  }) {
    return repository.getFilters(
      categoryId: categoryId,
      lang: lang,
    );
  }
}
