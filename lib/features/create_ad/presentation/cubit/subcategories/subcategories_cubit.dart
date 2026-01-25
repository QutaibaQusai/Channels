import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:channels/features/create_ad/domain/usecases/get_subcategories.dart';
import 'package:channels/features/create_ad/presentation/cubit/subcategories/subcategories_state.dart';

class SubcategoriesCubit extends Cubit<SubcategoriesState> {
  final GetSubcategories getSubcategoriesUseCase;
  final String lang;

  SubcategoriesCubit({
    required this.getSubcategoriesUseCase,
    required this.lang,
  }) : super(const SubcategoriesInitial());

  Future<void> fetchSubcategories(String categoryId) async {
    emit(const SubcategoriesLoading());
    try {
      final subcategories = await getSubcategoriesUseCase(
        categoryId: categoryId,
        lang: lang,
      );
      debugPrint('✅ Subcategories loaded successfully: ${subcategories.length} subcategories');
      emit(SubcategoriesSuccess(subcategories));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final isAuthError = statusCode == 401 || statusCode == 403;

      String errorMessage = 'An error occurred while loading subcategories';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message'] ??
            responseData['ErrorMessage'] ??
            errorMessage;
      }

      debugPrint('❌ DioException loading subcategories: $errorMessage');
      emit(SubcategoriesFailure(
        message: errorMessage,
        isAuthError: isAuthError,
      ));
    } catch (e) {
      debugPrint('❌ Unexpected error loading subcategories: $e');
      emit(SubcategoriesFailure(
        message: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }
}
