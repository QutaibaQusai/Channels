import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/ad_details/domain/usecases/get_ad_details.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:channels/core/errors/failures.dart';

/// Cubit for managing ad details state
class AdDetailsCubit extends Cubit<AdDetailsState> {
  final GetAdDetails getAdDetailsUseCase;

  AdDetailsCubit({required this.getAdDetailsUseCase})
    : super(const AdDetailsInitial());

  /// Fetch ad details by ID
  Future<void> fetchAdDetails({
    required String adId,
    required String languageCode,
  }) async {
    emit(const AdDetailsLoading());

    try {
      final adDetails = await getAdDetailsUseCase(
        adId: adId,
        languageCode: languageCode,
      );

      emit(AdDetailsSuccess(adDetails: adDetails));
    } on ServerFailure catch (e) {
      emit(AdDetailsFailure(errorMessage: e.message));
    } catch (e) {
      emit(AdDetailsFailure(errorMessage: e.toString()));
    }
  }

  /// Refresh ad details
  Future<void> refresh({
    required String adId,
    required String languageCode,
  }) async {
    await fetchAdDetails(adId: adId, languageCode: languageCode);
  }
}
