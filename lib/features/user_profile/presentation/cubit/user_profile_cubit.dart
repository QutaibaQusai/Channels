import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/user_profile/domain/usecases/get_user_profile.dart';
import 'package:channels/features/user_profile/presentation/cubit/user_profile_state.dart';
import 'package:channels/core/errors/failures.dart';

/// Cubit for managing user profile state
class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfile getUserProfileUseCase;

  UserProfileCubit({
    required this.getUserProfileUseCase,
  }) : super(const UserProfileInitial());

  /// Fetch user profile by user ID
  Future<void> fetchUserProfile({
    required String userId,
    required String languageCode,
  }) async {
    emit(const UserProfileLoading());

    try {
      final userProfile = await getUserProfileUseCase(
        userId: userId,
        languageCode: languageCode,
      );

      emit(UserProfileSuccess(userProfile: userProfile));
    } on ServerFailure catch (e) {
      emit(UserProfileFailure(errorMessage: e.message));
    } catch (e) {
      emit(UserProfileFailure(errorMessage: e.toString()));
    }
  }

  /// Refresh user profile
  Future<void> refresh({
    required String userId,
    required String languageCode,
  }) async {
    await fetchUserProfile(userId: userId, languageCode: languageCode);
  }
}
