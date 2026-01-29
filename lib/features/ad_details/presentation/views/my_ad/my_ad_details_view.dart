import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:channels/features/ad_details/presentation/views/widgets/ad_details_content.dart';
import 'package:channels/core/shared/widgets/app_dialog.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';

class MyAdDetailsView extends StatefulWidget {
  final String adId;

  const MyAdDetailsView({super.key, required this.adId});

  @override
  State<MyAdDetailsView> createState() => _MyAdDetailsViewState();
}

class _MyAdDetailsViewState extends State<MyAdDetailsView> {
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

  void _handleEdit() {
    final state = context.read<AdDetailsCubit>().state;
    if (state is AdDetailsSuccess) {
      context.pushNamed(RouteNames.updateAd, extra: state.adDetails);
    }
  }

  void _handleDelete(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    AppDialog.show(
      context,
      dialog: AppDialog(
        title: l10n.myAdDetailsDeleteDialogTitle,
        content: l10n.myAdDetailsDeleteDialogContent,
        primaryButtonText: l10n.actionDelete,
        onPrimaryButtonTap: () {
          Navigator.pop(context);
          context.read<AdDetailsCubit>().deleteAd(adId: widget.adId);
        },
        secondaryButtonText: l10n.commonCancel,
        isDestructive: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AdDetailsCubit, AdDetailsState>(
      listener: (context, state) {
        if (state is AdDetailsDeleteSuccess) {
          AppToast.success(context, title: l10n.actionDelete);
          Navigator.pop(
            context,
            true,
          ); // Return true to indicate refresh needed
        } else if (state is AdDetailsDeleteFailure) {
          AppToast.error(context, title: state.errorMessage);
        }
      },
      child: PieCanvas(
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppAppBar(title: l10n.myAdDetailsTitle, showBackButton: true),
          body: BlocBuilder<AdDetailsCubit, AdDetailsState>(
            builder: (context, state) {
              if (state is AdDetailsLoading ||
                  state is AdDetailsInitial ||
                  state is AdDetailsDeleting) {
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
                return AdDetailsContent(adDetails: state.adDetails);
              }

              return const SizedBox.shrink();
            },
          ),
          floatingActionButton: PieMenu(
            theme: PieTheme(
              delayDuration: Duration.zero,
              pointerColor: colorScheme.primary,
              buttonTheme: PieButtonTheme(
                backgroundColor: colorScheme.primary,
                iconColor: colorScheme.onPrimary,
              ),
              buttonThemeHovered: PieButtonTheme(
                backgroundColor: colorScheme.primary,
                iconColor: colorScheme.onPrimary,
              ),
              buttonSize: 56.sp,
            ),
            actions: [
              PieAction(
                tooltip: Text(l10n.actionEdit),
                onSelect: _handleEdit,
                child: const Icon(LucideIcons.edit),
              ),
              PieAction(
                tooltip: Text(l10n.actionDelete),
                onSelect: () => _handleDelete(context),
                child: Icon(LucideIcons.trash2, color: colorScheme.error),
              ),
            ],
            child: FloatingActionButton(
              heroTag: 'myAdDetailsFab',
              onPressed: () {},
              backgroundColor: colorScheme.primary,
              elevation: 0,
              shape: const CircleBorder(),
              child: Icon(
                LucideIcons.moreVertical,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
