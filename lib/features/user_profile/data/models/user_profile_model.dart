import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/user_profile/domain/entities/user_profile.dart';
import 'package:channels/features/user_profile/data/models/user_info_model.dart';
import 'package:channels/features/user_profile/data/models/user_ad_model.dart';

/// User Profile model - data layer
class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.user,
    required super.ads,
    required super.title,
    required super.subTitle,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      user: UserInfoModel.fromJson(json[ApiKey.user] as Map<String, dynamic>),
      ads: (json[ApiKey.ads] as List<dynamic>)
          .map((e) => UserAdModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json[ApiKey.title] as String,
      subTitle: json[ApiKey.subTitle] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.user: (user as UserInfoModel).toJson(),
      ApiKey.ads: ads
          .map((e) => UserAdModel(
                id: e.id,
                userId: e.userId,
                categoryId: e.categoryId,
                subcategoryId: e.subcategoryId,
                countryCode: e.countryCode,
                languageCode: e.languageCode,
                title: e.title,
                description: e.description,
                images: e.images,
                attributes: e.attributes,
                amount: e.amount,
                priceCurrency: e.priceCurrency,
                status: e.status,
                approved: e.approved,
                reportCount: e.reportCount,
                createdAt: e.createdAt,
                categoryName: e.categoryName,
                subcategoryName: e.subcategoryName,
              ).toJson())
          .toList(),
      ApiKey.title: title,
      ApiKey.subTitle: subTitle,
    };
  }
}
