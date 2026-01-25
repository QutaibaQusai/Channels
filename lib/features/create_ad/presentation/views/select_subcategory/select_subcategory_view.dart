import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:channels/core/api/dio_consumer.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/features/create_ad/data/data_sources/subcategories_remote_data_source.dart';
import 'package:channels/features/create_ad/data/repositories/subcategories_repository_impl.dart';
import 'package:channels/features/create_ad/domain/usecases/get_subcategories.dart';
import 'package:channels/features/create_ad/presentation/cubit/subcategories/subcategories_cubit.dart';
import 'package:channels/features/create_ad/presentation/cubit/subcategories/subcategories_state.dart';
import 'package:channels/features/create_ad/presentation/views/select_category/widgets/category_selection_list.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';

/// Select Subcategory View - Second step in creating an ad
/// User selects a subcategory within the chosen category
class SelectSubcategoryView extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String parentCategoryId; // For filters API

  const SelectSubcategoryView({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.parentCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => SubcategoriesCubit(
        getSubcategoriesUseCase: GetSubcategories(
          SubcategoriesRepositoryImpl(
            remoteDataSource: SubcategoriesRemoteDataSourceImpl(
              apiConsumer: DioConsumer(dio: Dio()),
            ),
          ),
        ),
        lang: langCode,
      )..fetchSubcategories(categoryId),
      child: _SelectSubcategoryBody(
        categoryName: categoryName,
        categoryId: categoryId,
        parentCategoryId: parentCategoryId,
      ),
    );
  }
}

class _SelectSubcategoryBody extends StatelessWidget {
  final String categoryName;
  final String categoryId;
  final String parentCategoryId;

  const _SelectSubcategoryBody({
    required this.categoryName,
    required this.categoryId,
    required this.parentCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppAppBar(
        title: categoryName,
        showBackButton: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: BlocConsumer<SubcategoriesCubit, SubcategoriesState>(
            listener: (context, state) {
              // Navigate to form when no subcategories are found (final level)
              if (state is SubcategoriesSuccess && state.subcategories.isEmpty) {
                context.replace(
                  RouteNames.adForm,
                  extra: {
                    'categoryId': categoryId,
                    'categoryName': categoryName,
                    'parentCategoryId': parentCategoryId, // For filters
                  },
                );
              }
            },
            builder: (context, state) {
              if (state is SubcategoriesLoading ||
                  state is SubcategoriesInitial) {
                return const AppLoading();
              }

              if (state is SubcategoriesFailure) {
                return ErrorStateWidget(
                  message: state.message,
                  isAuthError: state.isAuthError,
                  onRetry: () {
                    if (state.isAuthError) {
                      context.goNamed(RouteNames.onboarding);
                    } else {
                      context
                          .read<SubcategoriesCubit>()
                          .fetchSubcategories(categoryId);
                    }
                  },
                );
              }

              if (state is SubcategoriesSuccess) {
                // If no subcategories, show loading while listener handles navigation
                if (state.subcategories.isEmpty) {
                  return const AppLoading();
                }

                // Show subcategories and check recursively
                return CategorySelectionList(
                  categories: state.subcategories,
                  onCategorySelected: (subcategory) {
                    // Navigate to same view with new subcategory ID
                    // This will recursively check for more subcategories
                    // Keep passing parent category ID for filters
                    context.push(
                      RouteNames.selectSubcategory,
                      extra: {
                        'categoryId': subcategory.id,
                        'categoryName': subcategory.name,
                        'parentCategoryId': parentCategoryId, // Keep parent ID
                      },
                    );
                  },
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
