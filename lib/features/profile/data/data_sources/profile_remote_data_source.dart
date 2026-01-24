import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/profile/data/models/profile_model.dart';
import 'package:channels/features/profile/domain/entities/update_profile_params.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile({
    required String userId,
    required String languageCode,
  });

  Future<void> updateProfile({
    required String languageCode,
    required UpdateProfileParams params,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ProfileModel> getProfile({
    required String userId,
    required String languageCode,
  }) async {
    final response = await apiConsumer.get(
      EndPoint.userProfile(userId),
      data: {'lang': languageCode},
    );

    return ProfileModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<void> updateProfile({
    required String languageCode,
    required UpdateProfileParams params,
  }) async {
    final data = params.toJson();
    data['lang'] = languageCode;

    await apiConsumer.put(EndPoint.updatePreferences, data: data);
  }
}
