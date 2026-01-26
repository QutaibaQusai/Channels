import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_state.dart';
import 'package:channels/features/authentication/domain/usecases/update_preferences_usecase.dart';
import 'package:channels/features/authentication/domain/entities/country_entity.dart';
import 'package:channels/core/errors/exceptions.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UpdatePreferencesUseCase updatePreferencesUseCase;

  RegisterCubit({required this.updatePreferencesUseCase})
    : super(const RegisterInitial());

  // Update selected date
  void selectDate(DateTime date) {
    final currentState = state;
    if (currentState is RegisterInitial) {
      emit(RegisterInitial(
        selectedDate: date,
        selectedCountryCode: currentState.selectedCountryCode,
        selectedCountryName: currentState.selectedCountryName,
      ));
    } else {
      emit(RegisterInitial(selectedDate: date));
    }
  }

  // Update selected country
  void selectCountry(CountryEntity country) {
    final currentState = state;
    if (currentState is RegisterInitial) {
      emit(RegisterInitial(
        selectedDate: currentState.selectedDate,
        selectedCountryCode: country.code,
        selectedCountryName: country.name,
      ));
    } else {
      emit(RegisterInitial(
        selectedCountryCode: country.code,
        selectedCountryName: country.name,
      ));
    }
  }

  // Get formatted date string (YYYY-MM-DD)
  String? getFormattedDate() {
    final currentState = state;
    if (currentState is RegisterInitial && currentState.selectedDate != null) {
      final date = currentState.selectedDate!;
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
    return null;
  }

  Future<void> register({
    required String token,
    required String name,
    required String dateOfBirth,
    required String countryCode,
  }) async {
    emit(RegisterLoading());

    try {
      // Call update preferences use case
      await updatePreferencesUseCase(
        token: token,
        name: name,
        dateOfBirth: dateOfBirth,
        countryCode: countryCode,
      );

      // Emit success - just signal that registration completed
      emit(const RegisterSuccess());
    } on ServerException catch (e) {
      emit(RegisterFailure(errorMessage: e.errModel.errorMessage));
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
