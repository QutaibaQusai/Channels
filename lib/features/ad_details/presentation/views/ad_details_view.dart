import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_details_app_bar.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_details_content.dart';

/// Ad Details View - displays full details of an ad with immersive image header
/// Shared across Public Marketplace and My Ads
class AdDetailsView extends StatefulWidget {
  final String adId;
  final AdViewMode mode;

  const AdDetailsView({super.key, required this.adId, required this.mode});

  @override
  State<AdDetailsView> createState() => _AdDetailsViewState();
}

class _AdDetailsViewState extends State<AdDetailsView> {
  bool _hasFetched = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdDetailsCubit>(),
      child: Builder(
        builder: (context) {
          // Fetch data on initial build
          if (!_hasFetched) {
            _hasFetched = true;
            final locale = Localizations.localeOf(context);
            context.read<AdDetailsCubit>().fetchAdDetails(
              adId: widget.adId,
              languageCode: locale.languageCode,
            );
          }

          return _AdDetailsScaffold(adId: widget.adId, mode: widget.mode);
        },
      ),
    );
  }
}

class _AdDetailsScaffold extends StatelessWidget {
  final String adId;
  final AdViewMode mode;

  const _AdDetailsScaffold({required this.adId, required this.mode});

  void _fetchAdDetails(BuildContext context) {
    final locale = Localizations.localeOf(context);
    context.read<AdDetailsCubit>().fetchAdDetails(
      adId: adId,
      languageCode: locale.languageCode,
    );
  }

  void _handleShare() {
    // TODO: Implement share
  }

  void _handleFavorite() {
    // TODO: Implement favorite via separate cubit or ad details cubit
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
          mode: mode,
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
                onRetry: () => _fetchAdDetails(context),
              );
            }

            if (state is AdDetailsSuccess) {
              return AdDetailsContent(adDetails: state.adDetails, mode: mode);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
