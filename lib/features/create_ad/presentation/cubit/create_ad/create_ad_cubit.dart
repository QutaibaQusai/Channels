import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/errors/exceptions.dart';
import 'package:channels/features/create_ad/domain/usecases/create_ad.dart';
import 'package:channels/features/create_ad/presentation/cubit/create_ad/create_ad_state.dart';

class CreateAdCubit extends Cubit<CreateAdState> {
  final CreateAd createAdUseCase;

  CreateAdCubit({required this.createAdUseCase}) : super(const CreateAdInitial());

  Future<void> createAd({
    required String categoryId,
    required String subcategoryId,
    required String title,
    required String description,
    required double price,
    required List<File> images,
    required Map<String, dynamic> attributes,
  }) async {
    emit(const CreateAdLoading());

    try {
      final adId = await createAdUseCase.call(
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        title: title,
        description: description,
        price: price,
        images: images,
        attributes: attributes,
      );

      emit(CreateAdSuccess(adId));
    } on ServerException catch (e) {
      final isAuthError = e.errModel.status == 401;
      emit(CreateAdFailure(
        message: e.errModel.errorMessage,
        isAuthError: isAuthError,
      ));
    } catch (e) {
      emit(CreateAdFailure(message: 'Failed to create ad: ${e.toString()}'));
    }
  }
}