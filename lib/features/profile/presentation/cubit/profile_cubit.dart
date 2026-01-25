import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/features/profile/domain/entities/update_profile_params.dart';
import 'package:channels/features/profile/domain/usecases/get_profile.dart';
import 'package:channels/features/profile/domain/usecases/update_profile.dart';
import 'package:channels/features/profile/presentation/cubit/profile_state.dart';
import 'package:channels/core/errors/exceptions.dart';

import 'package:channels/core/services/secure_storage_service.dart';

/// Cubit for managing profile state
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfile getProfileUseCase;
  final UpdateProfile updateProfileUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(const ProfileInitial());

  /// Fetch user profile
  Future<void> fetchProfile({
    required String userId,
    required String languageCode,
  }) async {
    emit(const ProfileLoading());

    try {
      final profile = await getProfileUseCase(
        userId: userId,
        languageCode: languageCode,
      );

      emit(ProfileSuccess(profile: profile));
    } on ServerException catch (e) {
      emit(
        ProfileFailure(
          errorMessage: e.errModel.errorMessage,
          isAuthError: e.errModel.status == 401,
        ),
      );
    } catch (e) {
      emit(ProfileFailure(errorMessage: e.toString()));
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    required String languageCode,
    required UpdateProfileParams params,
  }) async {
    final currentState = state;
    if (currentState is! ProfileSuccess &&
        currentState is! ProfileUpdating &&
        currentState is! ProfileUpdateSuccess &&
        currentState is! ProfileUpdateFailure) {
      return;
    }

    // Get current profile from state
    final currentProfile = currentState is ProfileSuccess
        ? currentState.profile
        : currentState is ProfileUpdating
        ? currentState.profile
        : currentState is ProfileUpdateSuccess
        ? currentState.profile
        : (currentState as ProfileUpdateFailure).profile;

    emit(ProfileUpdating(profile: currentProfile));

    try {
      await updateProfileUseCase(languageCode: languageCode, params: params);

      // Create updated profile with new values
      final updatedProfile = _createUpdatedProfile(currentProfile, params);
      emit(ProfileUpdateSuccess(profile: updatedProfile));
    } on ServerException catch (e) {
      emit(
        ProfileUpdateFailure(
          profile: currentProfile,
          errorMessage: e.errModel.errorMessage,
          isAuthError: e.errModel.status == 401,
        ),
      );
    } catch (e) {
      emit(
        ProfileUpdateFailure(
          profile: currentProfile,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create updated profile from params
  Profile _createUpdatedProfile(Profile current, UpdateProfileParams params) {
    return Profile(
      id: current.id,
      name: params.name ?? current.name,
      phone: current.phone,
      status: current.status,
      languageCode: current.languageCode,
      countryCode: current.countryCode,
      dateOfBirth: params.dateOfBirth ?? current.dateOfBirth,
      createdAt: current.createdAt,
      isMe: current.isMe,
    );
  }

  /// Submit profile update from form data
  Future<void> submitUpdateProfile({
    required String languageCode,
    required String fullName,
    required String dob,
  }) async {
    final name = fullName.trim();
    final dateOfBirth = dob.trim();

    final params = UpdateProfileParams(
      name: name.isNotEmpty ? name : null,
      dateOfBirth: dateOfBirth.isNotEmpty ? dateOfBirth : null,
    );

    await updateProfile(languageCode: languageCode, params: params);
  }

  /// Refresh profile
  Future<void> refresh({
    required String userId,
    required String languageCode,
  }) async {
    await fetchProfile(userId: userId, languageCode: languageCode);
  }

  /// Toggle Do Not Disturb
  void toggleDoNotDisturb(bool value) {
    if (state is ProfileSuccess) {
      emit((state as ProfileSuccess).copyWith(doNotDisturb: value));
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      // Clear secure storage (tokens, userIds)
      await SecureStorageService.clearAll();

      // Clear image cache to ensure no user data/avatars persist
      imageCache.clear();
      imageCache.clearLiveImages();

      emit(const ProfileLoggedOut());
    } catch (e) {
      // Even if clear fails, we should logout locally
      emit(const ProfileLoggedOut());
    }
  }
}
