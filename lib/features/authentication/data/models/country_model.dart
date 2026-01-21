import 'package:channels/core/api/end_ponits.dart';

/// Country model for phone authentication
class CountryModel {
  final String code;
  final String name;
  final String dialingCode;
  final String placeholder;
  final String flagUrl;

  CountryModel({
    required this.code,
    required this.name,
    required this.dialingCode,
    required this.placeholder,
    required this.flagUrl,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json[ApiKey.code] as String,
      name: json[ApiKey.name] as String,
      dialingCode: json[ApiKey.dialingCode] as String,
      placeholder: json[ApiKey.placeholder] as String,
      flagUrl: json[ApiKey.flagUrl] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.code: code,
      ApiKey.name: name,
      ApiKey.dialingCode: dialingCode,
      ApiKey.placeholder: placeholder,
      ApiKey.flagUrl: flagUrl,
    };
  }
}
