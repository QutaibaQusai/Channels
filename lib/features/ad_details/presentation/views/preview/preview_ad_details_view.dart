import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_details_content.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Preview Ad Details View - For viewing ads without edit/delete options
/// Used for under review ads
class PreviewAdDetailsView extends StatefulWidget {
  final String adId;

  const PreviewAdDetailsView({super.key, required this.adId});

  @override
  State<PreviewAdDetailsView> createState() => _PreviewAdDetailsViewState();
}

class _PreviewAdDetailsViewState extends State<PreviewAdDetailsView> {
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppAppBar(title: l10n.myAdDetailsTitle, showBackButton: true),
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
            return AdDetailsContent(
              adDetails: state.adDetails,
              showStatusBadge: false,
              headerWidget: _buildUnderReviewBanner(context),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildUnderReviewBanner(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.screenPaddingH,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest),
      child: Row(
        children: [
          Icon(
            LucideIcons.clock,
            size: 18.sp,
            color: colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              l10n.previewUnderReviewMessage,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
