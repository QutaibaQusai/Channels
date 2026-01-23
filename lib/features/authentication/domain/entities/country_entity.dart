import 'package:equatable/equatable.dart';

/// Domain entity for country
class CountryEntity extends Equatable {
  final String code;
  final String name;
  final String dialCode;
  final String placeholder;
  final String flagUrl;

  const CountryEntity({
    required this.code,
    required this.name,
    required this.dialCode,
    required this.placeholder,
    required this.flagUrl,
  });

  @override
  List<Object?> get props => [code, name, dialCode, placeholder, flagUrl];
}
