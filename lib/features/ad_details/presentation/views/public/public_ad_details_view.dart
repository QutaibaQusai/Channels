import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/ad_details_app_bar.dart';
import 'package:channels/features/ad_details/presentation/views/public/widgets/public_ad_details_content.dart';

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

  Future<void> _handleShare() async {
    final state = context.read<AdDetailsCubit>().state;
    if (state is AdDetailsSuccess) {
      final adDetails = state.adDetails;

      // Create a shareable text message with ad details
      final shareText =
          '''
${adDetails.title}

${adDetails.formattedPrice}

${adDetails.description}

${adDetails.categoryName != null ? '📁 ${adDetails.categoryName}' : ''}
${adDetails.subcategoryName != null ? ' • ${adDetails.subcategoryName}' : ''}

📞 Contact: ${adDetails.phoneE164}
''';

      await SharePlus.instance.share(ShareParams(text: shareText.trim()));
    }
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
              return PublicAdDetailsContent(adDetails: state.adDetails);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
