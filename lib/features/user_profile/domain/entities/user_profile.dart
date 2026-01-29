import 'package:equatable/equatable.dart';
import 'package:channels/features/user_profile/domain/entities/user_info.dart';
import 'package:channels/features/user_profile/domain/entities/user_ad.dart';

/// User Profile entity - complete user profile with ads
class UserProfile extends Equatable {
  final UserInfo user;
  final List<UserAd> ads;
  final String title;
  final String subTitle;

  const UserProfile({
    required this.user,
    required this.ads,
    required this.title,
    required this.subTitle,
  });

  /// Get total number of ads
  int get totalAds => ads.length;

  /// Get active ads count
  int get activeAdsCount => ads.where((ad) => ad.status == 'active').length;

  /// Get approved ads count
  int get approvedAdsCount => ads.where((ad) => ad.isApproved).length;

  @override
  List<Object?> get props => [user, ads, title, subTitle];
}
