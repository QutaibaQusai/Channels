import 'package:equatable/equatable.dart';

/// Parameters for updating user profile
class UpdateProfileParams extends Equatable {
  final String? name;
  final String? dateOfBirth;

  const UpdateProfileParams({this.name, this.dateOfBirth});

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) {
      data['name'] = name;
    }
    if (dateOfBirth != null) {
      data['day-of-dirth'] = dateOfBirth;
    }

    return data;
  }

  @override
  List<Object?> get props => [name, dateOfBirth];
}
