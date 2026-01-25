import 'package:channels/core/api/end_points.dart';

/// Create Ad Response Model
class CreateAdResponseModel {
  final String status;
  final String id;

  const CreateAdResponseModel({
    required this.status,
    required this.id,
  });

  factory CreateAdResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateAdResponseModel(
      status: json[ApiKey.adStatus] as String,
      id: json[ApiKey.id] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.adStatus: status,
      ApiKey.id: id,
    };
  }
}