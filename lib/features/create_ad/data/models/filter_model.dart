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

    // Parse options - handle both string arrays and object arrays
    List<FilterOption>? options;
    if (optionsJson != null && optionsJson.isNotEmpty) {
      options = optionsJson.map((item) {
        if (item is String) {
          // Backend returns simple string array like ["بنزين", "هجين"]
          return FilterOptionModel(value: item, label: item);
        } else {
          // Backend returns object array with value/label
          return FilterOptionModel.fromJson(item as Map<String, dynamic>);
        }
      }).toList();
    }

    return FilterModel(
      id: json[ApiKey.id] as String,
      key: json[ApiKey.key] as String,
      type: json[ApiKey.type] as String,
      label: json[ApiKey.label] as String,
      options: options,
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
    final value = json[ApiKey.value] as String;
    final label = json[ApiKey.label] as String?;
    return FilterOptionModel(
      value: value,
      label: label ?? value, // Use value as label if label is null
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
