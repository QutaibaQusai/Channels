import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_app_bar.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_images.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_info.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_attributes.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/public_ad_action_buttons.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';

class PublicAdDetailsView extends StatefulWidget {
  final String adId;

  const PublicAdDetailsView({super.key, required this.adId});

  @override
  State<PublicAdDetailsView> createState() => _PublicAdDetailsViewState();
}

class _PublicAdDetailsViewState extends State<PublicAdDetailsView> {
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetched) {
      _hasFetched = true;
      final locale = Localizations.localeOf(context);
      context.read<AdDetailsCubit>().fetchAdDetails(
        adId: widget.adId,
        languageCode: locale.languageCode,
      );
    }
  }

  void _handleShare() {
    // TODO: Implement share
  }

  void _handleFavorite() {
    // TODO: Implement favorite
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: colorScheme.surface,
        appBar: AdDetailsAppBar(
          onShare: _handleShare,
          onFavorite: _handleFavorite,
          // Public mode enables both share and favorite by default in shared appbar?
          // I need to check shared appbar logic or just assume it shows what we pass callbacks for.
        ),
        body: BlocBuilder<AdDetailsCubit, AdDetailsState>(
          builder: (context, state) {
            if (state is AdDetailsLoading || state is AdDetailsInitial) {
              return const AppLoading();
            }

            if (state is AdDetailsFailure) {
              return ErrorStateWidget(
                message: state.errorMessage,
                onRetry: () {
                  final locale = Localizations.localeOf(context);
                  context.read<AdDetailsCubit>().fetchAdDetails(
                    adId: widget.adId,
                    languageCode: locale.languageCode,
                  );
                },
              );
            }

            if (state is AdDetailsSuccess) {
              return _buildContent(context, state.adDetails);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AdDetails adDetails) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Carousel
                AdDetailsImages(images: adDetails.images),

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
                          AdDetailsInfo(adDetails: adDetails),
                          verticalSpace(24.h),
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

        // Public Actions
        PublicAdActionButtons(phoneNumber: adDetails.phoneE164),
      ],
    );
  }
}
