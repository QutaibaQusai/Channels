import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_ponits.dart';
import 'package:channels/features/authentication/data/models/country_model.dart';

abstract class CountriesRemoteDataSource {
  Future<List<CountryModel>> getCountries(String languageCode);
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  final ApiConsumer apiConsumer;

  CountriesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<CountryModel>> getCountries(String languageCode) async {
    // Send language in request body
    final response = await apiConsumer.get(
      EndPoint.countries,
      data: {'lang': languageCode},
    );

    // Parse the response as a list of countries
    final List<dynamic> countriesJson = response as List<dynamic>;
    return countriesJson
        .map((json) => CountryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
