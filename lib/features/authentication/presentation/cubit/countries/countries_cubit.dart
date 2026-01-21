import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/data/data_sources/countries_remote_data_source.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountriesRemoteDataSource countriesRemoteDataSource;

  CountriesCubit({required this.countriesRemoteDataSource})
      : super(CountriesInitial());

  Future<void> getCountries() async {
    emit(CountriesLoading());
    try {
      final countries = await countriesRemoteDataSource.getCountries();
      emit(CountriesSuccess(countries: countries));
    } catch (e) {
      emit(CountriesFailure(errorMessage: e.toString()));
    }
  }
}
