import 'package:equatable/equatable.dart';
import 'package:channels/features/create_ad/domain/entities/subcategories_response.dart';

abstract class SubcategoriesState extends Equatable {
  const SubcategoriesState();

  @override
  List<Object?> get props => [];
}

class SubcategoriesInitial extends SubcategoriesState {
  const SubcategoriesInitial();
}

class SubcategoriesLoading extends SubcategoriesState {
  const SubcategoriesLoading();
}

class SubcategoriesSuccess extends SubcategoriesState {
  final SubcategoriesResponse data;

  const SubcategoriesSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class SubcategoriesFailure extends SubcategoriesState {
  final String message;
  final bool isAuthError;

  const SubcategoriesFailure({required this.message, this.isAuthError = false});

  @override
  List<Object?> get props => [message, isAuthError];
}
