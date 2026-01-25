import 'package:channels/features/create_ad/domain/entities/filter.dart';

abstract class FiltersRepository {
  Future<List<Filter>> getFilters({
    required String categoryId,
    required String lang,
  });
}
