import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_images.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_info.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_attributes.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/public_ad_action_buttons.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/similar_ads_section.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_user_info.dart';

/// Public ad details content widget - handles the success state layout
class PublicAdDetailsContent extends StatefulWidget {
  final AdDetails adDetails;

  const PublicAdDetailsContent({super.key, required this.adDetails});

  @override
  State<PublicAdDetailsContent> createState() => _PublicAdDetailsContentState();
}

class _PublicAdDetailsContentState extends State<PublicAdDetailsContent> {
  bool _isDescriptionExpanded = false;
  bool _hasLongDescription = false;
  final GlobalKey _descriptionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkDescriptionLength(),
    );
  }

  void _checkDescriptionLength() {
    final renderBox =
        _descriptionKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: widget.adDetails.description,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        maxLines: 5,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: renderBox.size.width);

      if (textPainter.didExceedMaxLines) {
        setState(() {
          _hasLongDescription = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Carousel
                AdDetailsImages(images: widget.adDetails.images),

                // Info card overlapping
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
                          AdDetailsInfo(adDetails: widget.adDetails),
                          verticalSpace(24.h),
                          if (widget.adDetails.attributes.isNotEmpty) ...[
                            AdDetailsAttributes(
                              attributes: widget.adDetails.attributes,
                            ),
                            verticalSpace(24.h),
                          ],
                          _buildTitle(context, widget.adDetails.title),
                          verticalSpace(12.h),
                          _buildDescription(
                            context,
                            widget.adDetails.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // User Info Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.screenPaddingH,
                  ),
                  child: AdUserInfo(
                    userName: widget.adDetails.userName,
                    userId: widget.adDetails.userId,
                    onTap: () {
                      context.push(RouteNames.userProfile, extra: widget.adDetails.userId);
                    },
                  ),
                ),

                // Similar Ads Section
                if (widget.adDetails.similarAds.isNotEmpty) ...[
                  verticalSpace(24.h),
                  SimilarAdsSection(similarAds: widget.adDetails.similarAds),
                  verticalSpace(24.h),
                ],
              ],
            ),
          ),
        ),

        // Public Actions
        PublicAdActionButtons(phoneNumber: widget.adDetails.phoneE164),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }

  Widget _buildDescription(BuildContext context, String description) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Text(
              key: _descriptionKey,
              description,
              maxLines: _isDescriptionExpanded ? null : 5,
              overflow: _isDescriptionExpanded
                  ? TextOverflow.visible
                  : TextOverflow.clip,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: colorScheme.onSurface,
                height: 1.5,
              ),
            ),
            if (!_isDescriptionExpanded && _hasLongDescription)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colorScheme.surface.withValues(alpha: 0.0),
                        colorScheme.surface.withValues(alpha: 0.5),
                        colorScheme.surface.withValues(alpha: 0.9),
                        colorScheme.surface,
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (_hasLongDescription) ...[
          verticalSpace(8.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _isDescriptionExpanded = !_isDescriptionExpanded;
              });
            },
            child: Row(
              children: [
                Text(
                  _isDescriptionExpanded ? 'See less' : 'See more',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  _isDescriptionExpanded
                      ? LucideIcons.chevronUp
                      : LucideIcons.chevronDown,
                  size: 16.sp,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
