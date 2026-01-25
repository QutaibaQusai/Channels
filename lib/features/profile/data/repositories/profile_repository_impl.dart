import 'package:channels/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/features/profile/domain/entities/update_profile_params.dart';
import 'package:channels/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Profile> getProfile({
    required String userId,
    required String languageCode,
  }) async {
    return await remoteDataSource.getProfile(
      userId: userId,
      languageCode: languageCode,
    );
  }

  @override
  Future<void> updateProfile({
    required String languageCode,
    required UpdateProfileParams params,
  }) async {
    await remoteDataSource.updateProfile(
      languageCode: languageCode,
      params: params,
    );
  }
}
