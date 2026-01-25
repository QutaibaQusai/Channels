import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:channels/core/api/dio_consumer.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/features/create_ad/data/data_sources/filters_remote_data_source.dart';
import 'package:channels/features/create_ad/data/repositories/filters_repository_impl.dart';
import 'package:channels/features/create_ad/domain/usecases/get_filters.dart';
import 'package:channels/features/create_ad/presentation/cubit/filters/filters_cubit.dart';
import 'package:channels/features/create_ad/presentation/cubit/filters/filters_state.dart';
import 'package:channels/features/create_ad/presentation/views/ad_form/widgets/dynamic_filter_list.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';

/// Ad Form View - Final step where user fills in ad details
/// Displays dynamic filters based on selected category
class AdFormView extends StatelessWidget {
  final String categoryId; // Selected category (for ad creation)
  final String categoryName;
  final String parentCategoryId; // Parent category (for filters)

  const AdFormView({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.parentCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => FiltersCubit(
        getFiltersUseCase: GetFilters(
          FiltersRepositoryImpl(
            remoteDataSource: FiltersRemoteDataSourceImpl(
              apiConsumer: DioConsumer(dio: Dio()),
            ),
          ),
        ),
        lang: langCode,
      )..fetchFilters(parentCategoryId),
      child: _AdFormBody(
        categoryName: categoryName,
        categoryId: categoryId,
        parentCategoryId: parentCategoryId,
      ),
    );
  }
}

class _AdFormBody extends StatelessWidget {
  final String categoryName;
  final String categoryId;
  final String parentCategoryId;

  const _AdFormBody({
    required this.categoryName,
    required this.categoryId,
    required this.parentCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppAppBar(title: categoryName, showBackButton: true),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: BlocBuilder<FiltersCubit, FiltersState>(
            builder: (context, state) {
              if (state is FiltersLoading || state is FiltersInitial) {
                return const AppLoading();
              }

              if (state is FiltersFailure) {
                return ErrorStateWidget(
                  message: state.message,
                  isAuthError: state.isAuthError,
                  onRetry: () {
                    if (state.isAuthError) {
                      context.goNamed(RouteNames.onboarding);
                    } else {
                      context.read<FiltersCubit>().fetchFilters(parentCategoryId);
                    }
                  },
                );
              }

              if (state is FiltersSuccess) {
                return DynamicFilterList(
                  filters: state.filters,
                  categoryId: categoryId,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
