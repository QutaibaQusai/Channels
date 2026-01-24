import 'package:channels/core/api/dio_consumer.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/features/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:channels/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:channels/features/categories/domain/usecases/get_categories.dart';
import 'package:channels/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:channels/features/categories/presentation/cubit/categories_state.dart';
import 'package:channels/features/categories/presentation/views/widgets/categories_success.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';

/// Categories view - browse ad categories
class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

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
      child: const _CategoriesBody(),
    );
  }
}

class _CategoriesBody extends StatelessWidget {
  const _CategoriesBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                  onRetry: () =>
                      context.read<CategoriesCubit>().fetchCategories(),
                );
              }

              if (state is CategoriesSuccess) {
                return CategoriesSuccessContent(
                  data: state.data,
                  onCategoryTap: (id) {
                    // Find the category name by id
                    final category = state.data.categories.firstWhere(
                      (cat) => cat.id == id,
                    );
                    context.push(
                      RouteNames.categoryAds,
                      extra: {'categoryId': id, 'categoryName': category.name},
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
