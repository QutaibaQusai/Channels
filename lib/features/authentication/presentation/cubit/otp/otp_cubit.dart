import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/data/data_sources/otp_remote_data_source.dart';
import 'package:channels/features/authentication/presentation/cubit/otp/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRemoteDataSource otpRemoteDataSource;

  OtpCubit({required this.otpRemoteDataSource}) : super(OtpInitial());

  Future<void> requestOtp({
    required String phone,
    required String countryCode,
  }) async {
    emit(OtpLoading());
    try {
      final response = await otpRemoteDataSource.requestOtp(
        phone: phone,
        countryCode: countryCode,
      );
      emit(OtpSuccess(message: response.message));
    } catch (e) {
      emit(OtpFailure(errorMessage: e.toString()));
    }
  }
}
