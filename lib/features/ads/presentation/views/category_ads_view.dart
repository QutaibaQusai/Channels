import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/api/dio_consumer.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/features/ads/data/data_sources/ads_remote_data_source.dart';
import 'package:channels/features/ads/data/repositories/ads_repository_impl.dart';
import 'package:channels/features/ads/domain/usecases/get_category_ads.dart';
import 'package:channels/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:channels/features/ads/presentation/views/widgets/ads_body.dart';

/// Category ads view - shows all ads for a specific category
class CategoryAdsView extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryAdsView({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => AdsCubit(
        getCategoryAdsUseCase: GetCategoryAds(
          AdsRepositoryImpl(
            remoteDataSource: AdsRemoteDataSourceImpl(
              apiConsumer: DioConsumer(dio: Dio()),
            ),
          ),
        ),
        categoryId: categoryId,
        lang: langCode,
      )..fetchAds(),
      child: Scaffold(
        appBar: AppAppBar(title: categoryName, showBackButton: true),
        body: const AdsBody(),
      ),
    );
  }
}
