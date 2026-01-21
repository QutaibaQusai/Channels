import 'package:equatable/equatable.dart';
import 'package:channels/features/authentication/data/models/country_model.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object?> get props => [];
}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesSuccess extends CountriesState {
  final List<CountryModel> countries;

  const CountriesSuccess({required this.countries});

  @override
  List<Object?> get props => [countries];
}

class CountriesFailure extends CountriesState {
  final String errorMessage;

  const CountriesFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
