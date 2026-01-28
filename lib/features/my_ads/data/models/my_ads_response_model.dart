import 'package:channels/features/my_ads/data/models/my_ad_model.dart';

class MyAdsResponseModel {
  final List<MyAdModel> ads;
  final String title;
  final String subTitle;

  const MyAdsResponseModel({
    required this.ads,
    required this.title,
    required this.subTitle,
  });

  factory MyAdsResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> adsJson =
        (json['ads'] as List<dynamic>? ?? <dynamic>[]);

    return MyAdsResponseModel(
      ads: adsJson
          .whereType<Map<String, dynamic>>()
          .map((item) => MyAdModel.fromJson(item))
          .toList(),
      title: json['title'] as String? ?? '',
      subTitle: json['sub_title'] as String? ?? '',
    );
  }
}
