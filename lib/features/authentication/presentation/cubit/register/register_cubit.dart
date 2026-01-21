import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_state.dart';
import 'package:channels/features/authentication/data/data_sources/update_preferences_remote_data_source.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UpdatePreferencesRemoteDataSource updatePreferencesRemoteDataSource;

  RegisterCubit({
    required this.updatePreferencesRemoteDataSource,
  }) : super(const RegisterInitial());

  Future<void> register({
    required String token,
    required String name,
    required String address,
  }) async {
    emit(RegisterLoading());

    try {
      // Call update preferences API
      await updatePreferencesRemoteDataSource.updatePreferences(
        token: token,
        name: name,
        address: address,
      );

      // Emit success - just signal that registration completed
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
