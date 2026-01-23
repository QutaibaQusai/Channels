import 'package:channels/features/authentication/domain/entities/country_entity.dart';
import 'package:channels/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for getting countries list
class GetCountriesUseCase {
  final AuthRepository repository;

  GetCountriesUseCase(this.repository);

  Future<List<CountryEntity>> call({
    required String languageCode,
  }) {
    return repository.getCountries(languageCode: languageCode);
  }
}
