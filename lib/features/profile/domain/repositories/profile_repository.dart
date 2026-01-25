import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/features/profile/domain/entities/update_profile_params.dart';

/// Abstract profile repository - domain layer
abstract class ProfileRepository {
  Future<Profile> getProfile({
    required String userId,
    required String languageCode,
  });

  Future<void> updateProfile({
    required String languageCode,
    required UpdateProfileParams params,
  });
}
