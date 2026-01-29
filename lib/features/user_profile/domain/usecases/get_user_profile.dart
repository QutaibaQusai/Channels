import 'package:channels/features/user_profile/domain/entities/user_profile.dart';
import 'package:channels/features/user_profile/domain/repositories/user_profile_repository.dart';

/// Use case for getting user profile
class GetUserProfile {
  final UserProfileRepository repository;

  GetUserProfile(this.repository);

  Future<UserProfile> call({
    required String userId,
    required String languageCode,
  }) async {
    return await repository.getUserProfile(
      userId: userId,
      languageCode: languageCode,
    );
  }
}
