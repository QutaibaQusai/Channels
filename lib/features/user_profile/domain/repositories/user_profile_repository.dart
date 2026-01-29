import 'package:channels/features/user_profile/domain/entities/user_profile.dart';

/// Repository interface for user profile operations
abstract class UserProfileRepository {
  /// Fetches user profile by user ID
  Future<UserProfile> getUserProfile({
    required String userId,
    required String languageCode,
  });
}
