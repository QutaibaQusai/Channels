import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/features/ads/presentation/cubit/ad_details/ad_details_cubit.dart';
import 'package:channels/features/ads/presentation/cubit/ad_details/ad_details_state.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_app_bar.dart';
import 'package:channels/features/ads/presentation/views/ad_details/widgets/ad_details_content.dart';

/// Ad Details View - displays full details of an ad with immersive image header
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

  void _handleShare() {
    // TODO: Implement share via cubit
  }

  void _handleFavorite() {
    // TODO: Implement favorite via cubit
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
        ),
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
              return AdDetailsContent(adDetails: state.adDetails);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
