import 'package:equatable/equatable.dart';
import 'package:channels/features/categories/domain/entities/categories_response.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final CategoriesResponse data;

  const CategoriesSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class CategoriesFailure extends CategoriesState {
  final String message;

  const CategoriesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
