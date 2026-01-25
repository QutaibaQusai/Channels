import 'package:channels/features/profile/domain/entities/update_profile_params.dart';
import 'package:channels/features/profile/domain/repositories/profile_repository.dart';

/// Use case for updating user profile
class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile({required this.repository});

  Future<void> call({
    required String languageCode,
    required UpdateProfileParams params,
  }) async {
    await repository.updateProfile(languageCode: languageCode, params: params);
  }
}
