import 'package:equatable/equatable.dart';
import 'package:channels/features/authentication/domain/entities/country_entity.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object?> get props => [];
}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesSuccess extends CountriesState {
  final List<CountryEntity> countries;

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
