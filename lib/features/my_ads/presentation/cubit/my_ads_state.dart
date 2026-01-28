import 'package:channels/features/my_ads/domain/entities/my_ad.dart';

sealed class MyAdsState {}

class MyAdsInitial extends MyAdsState {}

class MyAdsLoading extends MyAdsState {}

class MyAdsSuccess extends MyAdsState {
  final List<MyAd> ads;
  final String title;
  final String subTitle;

  MyAdsSuccess({
    required this.ads,
    required this.title,
    required this.subTitle,
  });
}

class MyAdsFailure extends MyAdsState {
  final String message;
  final bool isAuthError;

  MyAdsFailure({required this.message, this.isAuthError = false});
}
