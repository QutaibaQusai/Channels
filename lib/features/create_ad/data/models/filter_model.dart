import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';

class FilterModel extends Filter {
  const FilterModel({
    required super.id,
    required super.key,
    required super.type,
    required super.label,
    super.options,
    super.validation,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? optionsJson = json[ApiKey.options] as List<dynamic>?;
    final Map<String, dynamic>? validationJson =
        json[ApiKey.validation] as Map<String, dynamic>?;

    return FilterModel(
      id: json[ApiKey.id] as String,
      key: json[ApiKey.key] as String,
      type: json[ApiKey.type] as String,
      label: json[ApiKey.label] as String,
      options: optionsJson
          ?.map((item) =>
              FilterOptionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      validation: validationJson != null
          ? FilterValidationModel.fromJson(validationJson)
          : null,
    );
  }
}

class FilterOptionModel extends FilterOption {
  const FilterOptionModel({
    required super.value,
    super.label,
    super.parentValue,
  });

  factory FilterOptionModel.fromJson(Map<String, dynamic> json) {
    return FilterOptionModel(
      value: json[ApiKey.value] as String,
      label: json[ApiKey.label] as String?,
      parentValue: json['parent_value'] as String?,
    );
  }
}

class FilterValidationModel extends FilterValidation {
  const FilterValidationModel({
    super.min,
    super.max,
    super.step,
  });

  factory FilterValidationModel.fromJson(Map<String, dynamic> json) {
    return FilterValidationModel(
      min: (json['min'] as num?)?.toInt(),
      max: (json['max'] as num?)?.toInt(),
      step: (json['step'] as num?)?.toInt(),
    );
  }
}
