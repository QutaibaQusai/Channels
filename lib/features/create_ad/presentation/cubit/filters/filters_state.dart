import 'package:equatable/equatable.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object?> get props => [];
}

class FiltersInitial extends FiltersState {
  const FiltersInitial();
}

class FiltersLoading extends FiltersState {
  const FiltersLoading();
}

class FiltersSuccess extends FiltersState {
  final List<Filter> filters;

  const FiltersSuccess(this.filters);

  @override
  List<Object?> get props => [filters];
}

class FiltersFailure extends FiltersState {
  final String message;
  final bool isAuthError;

  const FiltersFailure({
    required this.message,
    this.isAuthError = false,
  });

  @override
  List<Object?> get props => [message, isAuthError];
}
