import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/ads/domain/usecases/get_category_ads.dart';
import 'package:channels/features/ads/presentation/cubit/ads/ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final GetCategoryAds getCategoryAdsUseCase;
  final String categoryId;
  final String lang;

  AdsCubit({
    required this.getCategoryAdsUseCase,
    required this.categoryId,
    required this.lang,
  }) : super(AdsInitial());

  Future<void> fetchAds() async {
    emit(AdsLoading());
    try {
      final ads = await getCategoryAdsUseCase(
        categoryId: categoryId,
        languageCode: lang,
      );
      emit(AdsSuccess(ads));
    } catch (e) {
      emit(AdsFailure(e.toString()));
    }
  }

  /// Refresh ads without showing loading state
  Future<void> refreshAds() async {
    try {
      final ads = await getCategoryAdsUseCase(
        categoryId: categoryId,
        languageCode: lang,
      );
      emit(AdsSuccess(ads));
    } catch (e) {
      emit(AdsFailure(e.toString()));
    }
  }
}
