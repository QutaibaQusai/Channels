import 'package:equatable/equatable.dart';

abstract class CreateAdState extends Equatable {
  const CreateAdState();

  @override
  List<Object?> get props => [];
}

class CreateAdInitial extends CreateAdState {
  const CreateAdInitial();
}

class CreateAdLoading extends CreateAdState {
  const CreateAdLoading();
}

class CreateAdSuccess extends CreateAdState {
  final String adId;

  const CreateAdSuccess(this.adId);

  @override
  List<Object?> get props => [adId];
}

class CreateAdFailure extends CreateAdState {
  final String message;
  final bool isAuthError;

  const CreateAdFailure({
    required this.message,
    this.isAuthError = false,
  });

  @override
  List<Object?> get props => [message, isAuthError];
}