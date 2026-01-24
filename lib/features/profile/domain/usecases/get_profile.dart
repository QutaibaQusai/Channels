import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/features/profile/domain/repositories/profile_repository.dart';

/// Use case to get user profile
class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Profile> call({
    required String userId,
    required String languageCode,
  }) async {
    return await repository.getProfile(
      userId: userId,
      languageCode: languageCode,
    );
  }
}
