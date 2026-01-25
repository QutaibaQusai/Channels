import 'package:equatable/equatable.dart';
import 'package:channels/features/categories/domain/entities/category.dart';

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
  final List<Category> subcategories;

  const SubcategoriesSuccess(this.subcategories);

  @override
  List<Object?> get props => [subcategories];
}

class SubcategoriesFailure extends SubcategoriesState {
  final String message;
  final bool isAuthError;

  const SubcategoriesFailure({
    required this.message,
    this.isAuthError = false,
  });

  @override
  List<Object?> get props => [message, isAuthError];
}
