import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';
import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_details_images.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_details_info.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_details_attributes.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_action_buttons.dart';

/// Main content widget for ad details with images, info, and fixed bottom action bar
class AdDetailsContent extends StatelessWidget {
  final AdDetails adDetails;
  final AdViewMode mode;

  const AdDetailsContent({
    super.key,
    required this.adDetails,
    required this.mode,
  });

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
                          AdDetailsInfo(adDetails: adDetails, mode: mode),

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

        // Fixed action buttons at bottom
        AdActionButtons(
          mode: mode,
          phoneNumber: adDetails.phoneE164,
          onEdit: () {
            // TODO: Navigate to edit ad
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Edit feature coming soon!')),
            );
          },
          onDelete: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Ad'),
                content: const Text(
                  'Are you sure you want to delete this ad? This action cannot be undone.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Implement delete logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Delete feature coming soon!'),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
