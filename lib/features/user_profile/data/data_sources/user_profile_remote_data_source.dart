import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/features/user_profile/data/models/user_profile_model.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile({
    required String userId,
    required String languageCode,
  });
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  UserProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserProfileModel> getUserProfile({
    required String userId,
    required String languageCode,
  }) async {
    final response = await apiConsumer.post(
      'ads/user/$userId',
      data: {'lang': languageCode},
    );

    return UserProfileModel.fromJson(response as Map<String, dynamic>);
  }
}
