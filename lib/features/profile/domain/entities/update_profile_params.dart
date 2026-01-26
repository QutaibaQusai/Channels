import 'package:equatable/equatable.dart';

/// Parameters for updating user profile
class UpdateProfileParams extends Equatable {
  final String? name;
  final String? dateOfBirth;
  final String? countryCode;

  const UpdateProfileParams({
    this.name,
    this.dateOfBirth,
    this.countryCode,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) {
      data['name'] = name;
    }
    if (dateOfBirth != null) {
      data['day-of-dirth'] = dateOfBirth;
    }
    if (countryCode != null) {
      data['country_code'] = countryCode;
    }

    return data;
  }

  @override
  List<Object?> get props => [name, dateOfBirth, countryCode];
}
