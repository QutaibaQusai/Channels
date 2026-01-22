import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/categories/domain/usecases/get_categories.dart';
import 'package:channels/features/categories/presentation/cubit/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategories getCategoriesUseCase;
  final String lang;
  final String? country;
  final String? parentId;

  CategoriesCubit({
    required this.getCategoriesUseCase,
    required this.lang,
    this.country,
    this.parentId,
  }) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final result = await getCategoriesUseCase(
        lang: lang,
        country: country,
        parentId: parentId,
      );
      emit(CategoriesSuccess(result));
    } catch (e) {
      emit(CategoriesFailure(e.toString()));
    }
  }

  /// Refresh categories without showing loading state
  Future<void> refreshCategories() async {
    try {
      final result = await getCategoriesUseCase(
        lang: lang,
        country: country,
        parentId: parentId,
      );
      emit(CategoriesSuccess(result));
    } catch (e) {
      emit(CategoriesFailure(e.toString()));
    }
  }
}
