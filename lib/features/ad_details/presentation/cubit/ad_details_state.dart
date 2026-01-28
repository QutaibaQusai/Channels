import 'package:equatable/equatable.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';

/// States for ad details cubit
abstract class AdDetailsState extends Equatable {
  const AdDetailsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AdDetailsInitial extends AdDetailsState {
  const AdDetailsInitial();
}

/// Loading state
class AdDetailsLoading extends AdDetailsState {
  const AdDetailsLoading();
}

/// Success state with ad details
class AdDetailsSuccess extends AdDetailsState {
  final AdDetails adDetails;

  const AdDetailsSuccess({required this.adDetails});

  @override
  List<Object?> get props => [adDetails];
}

/// Failure state with error message
class AdDetailsFailure extends AdDetailsState {
  final String errorMessage;

  const AdDetailsFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
