import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/errors/exceptions.dart';
import 'package:channels/features/my_ads/domain/usecases/get_my_ads.dart';
import 'package:channels/features/my_ads/presentation/cubit/my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  final GetMyAds getMyAdsUseCase;

  MyAdsCubit({required this.getMyAdsUseCase}) : super(MyAdsInitial());

  Future<void> fetchMyAds() async {
    emit(MyAdsLoading());
    try {
      final (ads, title, subTitle) = await getMyAdsUseCase();
      emit(MyAdsSuccess(ads: ads, title: title, subTitle: subTitle));
    } on ServerException catch (e) {
      final isAuthError = e.errModel.status == 401 || e.errModel.status == 403;
      emit(MyAdsFailure(
        message: e.errModel.errorMessage,
        isAuthError: isAuthError,
      ));
    } catch (e) {
      emit(MyAdsFailure(message: e.toString()));
    }
  }

  Future<void> refreshMyAds() async {
    // Don't show loading state for refresh
    try {
      final (ads, title, subTitle) = await getMyAdsUseCase();
      emit(MyAdsSuccess(ads: ads, title: title, subTitle: subTitle));
    } on ServerException catch (e) {
      final isAuthError = e.errModel.status == 401 || e.errModel.status == 403;
      emit(MyAdsFailure(
        message: e.errModel.errorMessage,
        isAuthError: isAuthError,
      ));
    } catch (e) {
      emit(MyAdsFailure(message: e.toString()));
    }
  }
}
