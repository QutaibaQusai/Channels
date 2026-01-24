import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/features/ads/presentation/cubit/ad_details/ad_details_cubit.dart';
import 'package:channels/features/ads/presentation/cubit/ad_details/ad_details_state.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_images.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_info.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_attributes.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_contact_button.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Ad Details View - displays full details of an ad
class AdDetailsView extends StatefulWidget {
  final String adId;

  const AdDetailsView({super.key, required this.adId});

  @override
  State<AdDetailsView> createState() => _AdDetailsViewState();
}

class _AdDetailsViewState extends State<AdDetailsView> {
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Only fetch once on first build (locale is available here)
    if (!_hasFetched) {
      _hasFetched = true;
      _fetchAdDetails();
    }
  }

  void _fetchAdDetails() {
    final locale = Localizations.localeOf(context);
    context.read<AdDetailsCubit>().fetchAdDetails(
      adId: widget.adId,
      languageCode: locale.languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppAppBar(title: l10n.adDetailsTitle, showBackButton: true),
      body: BlocBuilder<AdDetailsCubit, AdDetailsState>(
        builder: (context, state) {
          if (state is AdDetailsLoading || state is AdDetailsInitial) {
            return const AppLoading();
          }

          if (state is AdDetailsFailure) {
            return ErrorStateWidget(
              message: state.errorMessage,
              onRetry: _fetchAdDetails,
            );
          }

          if (state is AdDetailsSuccess) {
            final ad = state.adDetails;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Images carousel
                        AdDetailsImages(images: ad.images),

                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title, price, info
                              AdDetailsInfo(adDetails: ad),

                              SizedBox(height: 24.h),

                              // Attributes (year, color, make, etc.)
                              if (ad.attributes.isNotEmpty)
                                AdDetailsAttributes(attributes: ad.attributes),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Contact button fixed at bottom
                AdContactButton(phoneNumber: ad.phoneE164),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
