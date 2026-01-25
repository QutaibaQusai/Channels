import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:channels/features/create_ad/domain/usecases/get_filters.dart';
import 'package:channels/features/create_ad/presentation/cubit/filters/filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  final GetFilters getFiltersUseCase;
  final String lang;

  FiltersCubit({
    required this.getFiltersUseCase,
    required this.lang,
  }) : super(const FiltersInitial());

  Future<void> fetchFilters(String categoryId) async {
    emit(const FiltersLoading());
    try {
      final filters = await getFiltersUseCase(
        categoryId: categoryId,
        lang: lang,
      );
      debugPrint('✅ Filters loaded successfully: ${filters.length} filters');
      emit(FiltersSuccess(filters));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final isAuthError = statusCode == 401 || statusCode == 403;

      String errorMessage = 'An error occurred while loading filters';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message'] ??
            responseData['ErrorMessage'] ??
            errorMessage;
      }

      debugPrint('❌ DioException loading filters: $errorMessage');
      emit(FiltersFailure(
        message: errorMessage,
        isAuthError: isAuthError,
      ));
    } catch (e) {
      debugPrint('❌ Unexpected error loading filters: $e');
      emit(FiltersFailure(
        message: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }
}
