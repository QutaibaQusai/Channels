import 'package:equatable/equatable.dart';

/// Filter entity representing a dynamic form field
class Filter extends Equatable {
  final String id;
  final String key;
  final String type; // "select", "text", etc.
  final String label;
  final String? title;
  final String? subTitle;
  final List<FilterOption>? options;
  final FilterValidation? validation;

  const Filter({
    required this.id,
    required this.key,
    required this.type,
    required this.label,
    this.title,
    this.subTitle,
    this.options,
    this.validation,
  });

  @override
  List<Object?> get props => [id, key, type, label, title, subTitle, options, validation];
}

/// Filter option for select-type filters
class FilterOption extends Equatable {
  final String value;
  final String? label;
  final String? parentValue;

  const FilterOption({
    required this.value,
    this.label,
    this.parentValue,
  });

  @override
  List<Object?> get props => [value, label, parentValue];
}

/// Validation rules for filters
class FilterValidation extends Equatable {
  final int? min;
  final int? max;
  final int? step;

  const FilterValidation({
    this.min,
    this.max,
    this.step,
  });

  @override
  List<Object?> get props => [min, max, step];
}
