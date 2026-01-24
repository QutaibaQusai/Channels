import 'package:equatable/equatable.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';

/// States for profile cubit
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Success state with profile data
class ProfileSuccess extends ProfileState {
  final Profile profile;
  final bool doNotDisturb;

  const ProfileSuccess({required this.profile, this.doNotDisturb = false});

  ProfileSuccess copyWith({Profile? profile, bool? doNotDisturb}) {
    return ProfileSuccess(
      profile: profile ?? this.profile,
      doNotDisturb: doNotDisturb ?? this.doNotDisturb,
    );
  }

  @override
  List<Object?> get props => [profile, doNotDisturb];
}

/// Failure state with error message
class ProfileFailure extends ProfileState {
  final String errorMessage;

  const ProfileFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

/// Updating profile state (keeps current profile visible)
class ProfileUpdating extends ProfileState {
  final Profile profile;

  const ProfileUpdating({required this.profile});

  @override
  List<Object?> get props => [profile];
}

/// Profile update success
class ProfileUpdateSuccess extends ProfileState {
  final Profile profile;

  const ProfileUpdateSuccess({required this.profile});

  @override
  List<Object?> get props => [profile];
}

/// Profile update failure
class ProfileUpdateFailure extends ProfileState {
  final Profile profile;
  final String errorMessage;

  const ProfileUpdateFailure({
    required this.profile,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [profile, errorMessage];
}

/// Logged out state
class ProfileLoggedOut extends ProfileState {
  const ProfileLoggedOut();
}
