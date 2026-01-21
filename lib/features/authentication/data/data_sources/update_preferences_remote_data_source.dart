import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_ponits.dart';
import 'package:channels/features/authentication/data/models/update_preferences_model.dart';

abstract class UpdatePreferencesRemoteDataSource {
  Future<UpdatePreferencesResponseModel> updatePreferences({
    required String token,
    required String name,
    required String dateOfBirth,
  });
}

class UpdatePreferencesRemoteDataSourceImpl
    implements UpdatePreferencesRemoteDataSource {
  final ApiConsumer apiConsumer;

  UpdatePreferencesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UpdatePreferencesResponseModel> updatePreferences({
    required String token,
    required String name,
    required String dateOfBirth,
  }) async {
    // Create request model
    final requestModel = UpdatePreferencesRequestModel(
      name: name,
      dateOfBirth: dateOfBirth,
    );

    // Make API call with Authorization header
    final response = await apiConsumer.put(
      EndPoint.updatePreferences,
      data: requestModel.toJson(),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    // Check if response is null
    if (response == null) {
      throw Exception('API response is null');
    }

    // Check if response is a Map
    if (response is! Map<String, dynamic>) {
      throw Exception('API response is not a valid Map: ${response.runtimeType}');
    }

    // Parse response
    return UpdatePreferencesResponseModel.fromJson(response);
  }
}
