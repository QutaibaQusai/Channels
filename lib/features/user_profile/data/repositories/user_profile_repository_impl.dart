import 'package:channels/core/errors/exceptions.dart';
import 'package:channels/core/errors/failures.dart';
import 'package:channels/features/user_profile/data/data_sources/user_profile_remote_data_source.dart';
import 'package:channels/features/user_profile/domain/entities/user_profile.dart';
import 'package:channels/features/user_profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfile> getUserProfile({
    required String userId,
    required String languageCode,
  }) async {
    try {
      return await remoteDataSource.getUserProfile(
        userId: userId,
        languageCode: languageCode,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.errModel.errorMessage);
    }
  }
}
