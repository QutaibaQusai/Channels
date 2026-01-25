import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:channels/core/api/dio_consumer.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/features/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:channels/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:channels/features/categories/domain/usecases/get_categories.dart';
import 'package:channels/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:channels/features/categories/presentation/cubit/categories_state.dart';
import 'package:channels/features/create_ad/presentation/views/select_category/widgets/category_selection_list.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';

/// Select Category View - First step in creating an ad
/// User selects a category for their ad
class SelectCategoryView extends StatelessWidget {
  const SelectCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => CategoriesCubit(
        getCategoriesUseCase: GetCategories(
          CategoriesRepositoryImpl(
            remoteDataSource: CategoriesRemoteDataSourceImpl(
              apiConsumer: DioConsumer(dio: Dio()),
            ),
          ),
        ),
        lang: langCode,
      )..fetchCategories(),
      child: const _SelectCategoryBody(),
    );
  }
}

class _SelectCategoryBody extends StatelessWidget {
  const _SelectCategoryBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const AppAppBar(
        title: 'Select Category',
        showBackButton: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading || state is CategoriesInitial) {
                return const AppLoading();
              }

              if (state is CategoriesFailure) {
                return ErrorStateWidget(
                  message: state.message,
                  isAuthError: state.isAuthError,
                  onRetry: () {
                    if (state.isAuthError) {
                      context.goNamed(RouteNames.onboarding);
                    } else {
                      context.read<CategoriesCubit>().fetchCategories();
                    }
                  },
                );
              }

              if (state is CategoriesSuccess) {
                return CategorySelectionList(
                  categories: state.data.categories,
                  onCategorySelected: (category) {
                    // Navigate to subcategory selection
                    // Pass parent category ID for filters
                    context.push(
                      RouteNames.selectSubcategory,
                      extra: {
                        'categoryId': category.id,
                        'categoryName': category.name,
                        'parentCategoryId': category.id, // For filters API
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
