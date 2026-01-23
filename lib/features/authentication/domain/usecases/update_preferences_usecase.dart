import 'package:channels/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for updating user preferences
class UpdatePreferencesUseCase {
  final AuthRepository repository;

  UpdatePreferencesUseCase(this.repository);

  Future<void> call({
    required String token,
    required String name,
    required String dateOfBirth,
  }) {
    return repository.updatePreferences(
      token: token,
      name: name,
      dateOfBirth: dateOfBirth,
    );
  }
}
