import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/ads/domain/entities/ad_details.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_images.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_info.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_attributes.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_contact_button.dart';

/// Main content widget for ad details with images, info, and fixed bottom contact bar
class AdDetailsContent extends StatelessWidget {
  final AdDetails adDetails;

  const AdDetailsContent({super.key, required this.adDetails});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Immersive image carousel
                AdDetailsImages(images: adDetails.images),

                // Content with rounded top corners overlapping the image
                Transform.translate(
                  offset: Offset(0, -24.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSizes.r24),
                        topRight: Radius.circular(AppSizes.r24),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppSizes.screenPaddingH,
                        24.h,
                        AppSizes.screenPaddingH,
                        16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title, price, info
                          AdDetailsInfo(adDetails: adDetails),

                          verticalSpace(24.h),

                          // Attributes (year, color, make, etc.)
                          if (adDetails.attributes.isNotEmpty)
                            AdDetailsAttributes(
                              attributes: adDetails.attributes,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Fixed contact button at bottom
        AdContactButton(phoneNumber: adDetails.phoneE164),
      ],
    );
  }
}
