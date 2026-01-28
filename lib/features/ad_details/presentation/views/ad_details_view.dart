import 'package:flutter/material.dart';
import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';
import 'package:channels/features/ad_details/presentation/views/public/public_ad_details_view.dart';
import 'package:channels/features/ad_details/presentation/views/my_ad/my_ad_details_view.dart';
import 'package:channels/features/ad_details/presentation/views/preview/preview_ad_details_view.dart';

/// Ad Details View - displays full details of an ad with immersive image header
/// Shared across Public Marketplace and My Ads
class AdDetailsView extends StatelessWidget {
  final String adId;
  final AdViewMode mode;

  const AdDetailsView({
    super.key,
    required this.adId,
    this.mode = AdViewMode.public,
  });

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case AdViewMode.public:
        return PublicAdDetailsView(adId: adId);
      case AdViewMode.myAd:
        return MyAdDetailsView(adId: adId);
      case AdViewMode.preview:
        return PreviewAdDetailsView(adId: adId);
    }
  }
}
