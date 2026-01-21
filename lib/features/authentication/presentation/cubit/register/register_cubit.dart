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
    print('🟢 RegisterCubit: Starting registration');
    print('🟢 Token: $token');
    print('🟢 Name: $name');
    print('🟢 Address: $address');

    emit(RegisterLoading());

    try {
      print('🟢 RegisterCubit: Calling API...');
      // Call update preferences API
      final response = await updatePreferencesRemoteDataSource.updatePreferences(
        token: token,
        name: name,
        address: address,
      );

      print('🟢 RegisterCubit: API call successful');
      print('🟢 Status: ${response.status}');

      // Emit success - just signal that registration completed
      emit(const RegisterSuccess());
    } catch (e) {
      print('🔴 RegisterCubit: Error occurred');
      print('🔴 Error: $e');
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
