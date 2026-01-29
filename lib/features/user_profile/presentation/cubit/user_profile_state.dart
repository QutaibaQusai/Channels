import 'package:equatable/equatable.dart';
import 'package:channels/features/user_profile/domain/entities/user_profile.dart';

/// States for user profile cubit
abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

/// Loading state
class UserProfileLoading extends UserProfileState {
  const UserProfileLoading();
}

/// Success state with user profile
class UserProfileSuccess extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileSuccess({required this.userProfile});

  @override
  List<Object?> get props => [userProfile];
}

/// Failure state with error message
class UserProfileFailure extends UserProfileState {
  final String errorMessage;

  const UserProfileFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
