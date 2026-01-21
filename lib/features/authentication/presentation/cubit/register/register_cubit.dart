import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_state.dart';
import 'package:channels/features/authentication/data/data_sources/update_preferences_remote_data_source.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UpdatePreferencesRemoteDataSource updatePreferencesRemoteDataSource;

  RegisterCubit({
    required this.updatePreferencesRemoteDataSource,
  }) : super(const RegisterInitial());

  // Update selected date
  void selectDate(DateTime date) {
    emit(RegisterInitial(selectedDate: date));
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
  }) async {
    emit(RegisterLoading());

    try {
      // Call update preferences API
      await updatePreferencesRemoteDataSource.updatePreferences(
        token: token,
        name: name,
        dateOfBirth: dateOfBirth,
      );

      // Emit success - just signal that registration completed
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
