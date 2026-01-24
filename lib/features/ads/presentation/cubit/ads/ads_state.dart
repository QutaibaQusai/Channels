import 'package:channels/features/ads/domain/entities/ad.dart';

/// Ads state - presentation layer
sealed class AdsState {}

class AdsInitial extends AdsState {}

class AdsLoading extends AdsState {}

class AdsSuccess extends AdsState {
  final List<Ad> ads;

  AdsSuccess(this.ads);
}

class AdsFailure extends AdsState {
  final String message;

  AdsFailure(this.message);
}
