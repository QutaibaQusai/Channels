import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/domain/usecases/get_countries_usecase.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final GetCountriesUseCase getCountriesUseCase;
  final String languageCode;

  CountriesCubit({
    required this.getCountriesUseCase,
    required this.languageCode,
  }) : super(CountriesInitial());

  Future<void> getCountries() async {
    emit(CountriesLoading());
    try {
      final countries = await getCountriesUseCase(languageCode: languageCode);
      emit(CountriesSuccess(countries: countries));
    } catch (e) {
      emit(CountriesFailure(errorMessage: e.toString()));
    }
  }

  /// Refresh countries without showing loading state
  Future<void> refreshCountries() async {
    try {
      final countries = await getCountriesUseCase(languageCode: languageCode);
      emit(CountriesSuccess(countries: countries));
    } catch (e) {
      emit(CountriesFailure(errorMessage: e.toString()));
    }
  }
}
