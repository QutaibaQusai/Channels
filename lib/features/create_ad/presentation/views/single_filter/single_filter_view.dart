import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';
import 'package:channels/features/create_ad/presentation/views/ad_form/widgets/filter_option_card.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Single Filter View - Shows one filter at a time for better UX
class SingleFilterView extends StatefulWidget {
  final List<Filter> allFilters; // All filters for this category
  final int currentFilterIndex; // Current filter being displayed
  final Map<String, dynamic> collectedData; // Previously collected answers
  final Map<String, String> displayData; // Human readable data for review
  final String categoryId; // The selected subcategory ID
  final String parentCategoryId; // The parent category ID (for filters/API)
  final String rootCategoryId; // Root category (for API submission)

  const SingleFilterView({
    super.key,
    required this.allFilters,
    required this.currentFilterIndex,
    required this.collectedData,
    required this.displayData,
    required this.categoryId,
    required this.parentCategoryId,
    required this.rootCategoryId,
  });

  @override
  State<SingleFilterView> createState() => _SingleFilterViewState();
}

class _SingleFilterViewState extends State<SingleFilterView> {
  late TextEditingController _textController;
  String? _selectedOption;
  Set<String> _selectedOptions = {}; // For multiselect
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    // Get current filter
    final filter = widget.allFilters[widget.currentFilterIndex];

    // Debug: Print what we received
    debugPrint('🔍 SingleFilterView initState');
    debugPrint('🔍 Total filters: ${widget.allFilters.length}');
    debugPrint('🔍 Current index: ${widget.currentFilterIndex}');
    debugPrint('🔍 Current filter: ${filter.label}');
    debugPrint('🔍 Filter type: ${filter.type}');
    debugPrint('🔍 Options count: ${filter.options?.length ?? 0}');
    if (filter.options != null && filter.options!.isNotEmpty) {
      debugPrint('🔍 First option: ${filter.options!.first.value}');
      debugPrint('🔍 First option label: ${filter.options!.first.label}');
    }

    // Pre-fill if user navigated back
    final previousValue = widget.collectedData[filter.key];
    if (previousValue != null) {
      if (filter.type == 'select') {
        _selectedOption = previousValue.toString();
      } else if (filter.type == 'multiselect') {
        // Previous value could be a List
        if (previousValue is List) {
          _selectedOptions = previousValue.map((e) => e.toString()).toSet();
        }
      } else {
        _textController.text = previousValue.toString();
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Filter get currentFilter => widget.allFilters[widget.currentFilterIndex];

  bool get isLastFilter =>
      widget.currentFilterIndex == widget.allFilters.length - 1;

  void _handleNext() {
    // Validate based on filter type
    if (currentFilter.type == 'select') {
      if (_selectedOption == null) {
        // Show error toast
        return;
      }
    } else if (currentFilter.type == 'multiselect') {
      if (_selectedOptions.isEmpty) {
        // Show error toast - at least one option must be selected
        return;
      }
    } else {
      if (!(_formKey.currentState?.validate() ?? false)) {
        return;
      }
    }

    // Save current answer
    final updatedData = Map<String, dynamic>.from(widget.collectedData);
    final updatedDisplayData = Map<String, String>.from(widget.displayData);

    if (currentFilter.type == 'select') {
      updatedData[currentFilter.key] = _selectedOption;

      // Find display label
      String displayLabel = _selectedOption.toString();
      // Ensure we have a standard List<FilterOption> to avoid runtime type issues with firstWhere
      List<FilterOption> options = List<FilterOption>.from(
        currentFilter.options ?? [],
      );

      // Handle generated options (same logic as build)
      if (options.isEmpty && currentFilter.validation != null) {
        final validation = currentFilter.validation!;
        if (validation.min != null && validation.max != null) {
          final step = validation.step ?? 1;
          for (int i = validation.max!; i >= validation.min!; i -= step) {
            options.add(FilterOption(value: i.toString(), label: i.toString()));
          }
        }
      }

      final option = options.firstWhere(
        (o) => o.value == _selectedOption,
        orElse: () => FilterOption(
          value: _selectedOption.toString(),
          label: _selectedOption.toString(),
        ),
      );
      displayLabel = option.label ?? option.value;
      updatedDisplayData[currentFilter.label] = displayLabel;
    } else if (currentFilter.type == 'multiselect') {
      // Save as list for multiselect
      updatedData[currentFilter.key] = _selectedOptions.toList();

      // Find display labels
      List<FilterOption> options = List<FilterOption>.from(
        currentFilter.options ?? [],
      );

      final displayLabels = _selectedOptions
          .map((value) {
            final option = options.firstWhere(
              (o) => o.value == value,
              orElse: () => FilterOption(value: value, label: value),
            );
            return option.label ?? option.value;
          })
          .join(', ');

      updatedDisplayData[currentFilter.label] = displayLabels;
    } else {
      final value = _textController.text.trim();
      updatedData[currentFilter.key] = value;
      updatedDisplayData[currentFilter.label] = value;
    }

    // Navigate to next filter or upload images
    if (isLastFilter) {
      // All filters completed, go to upload images
      context.push(
        RouteNames.uploadImages,
        extra: {
          'formData': updatedData,
          'displayData': updatedDisplayData,
          'categoryId': widget.categoryId,
          'parentCategoryId': widget.parentCategoryId,
          'rootCategoryId': widget.rootCategoryId,
        },
      );
    } else {
      // Navigate to next filter (allow back navigation)
      context.push(
        RouteNames.singleFilter,
        extra: {
          'allFilters': widget.allFilters,
          'currentFilterIndex': widget.currentFilterIndex + 1,
          'collectedData': updatedData,
          'displayData': updatedDisplayData,
          'categoryId': widget.categoryId,
          'parentCategoryId': widget.parentCategoryId,
          'rootCategoryId': widget.rootCategoryId,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppAppBar(title: currentFilter.label, showBackButton: true),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (widget.currentFilterIndex + 1) / widget.allFilters.length,
              minHeight: 4.h,
            ),

            // Content with gradient overlay
            Expanded(
              child: GradientOverlay(
                bottomWidget: Padding(
                  padding: EdgeInsets.all(AppSizes.screenPaddingH),
                  child: AppButton(
                    text: isLastFilter ? 'Upload Images' : l10n.commonNext,
                    onPressed: _handleNext,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSizes.s96,
                    left: AppSizes.screenPaddingH,
                    right: AppSizes.screenPaddingH,
                  ),
                  child: _buildFilterInput(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterInput() {
    if (currentFilter.type == 'select') {
      return _buildSelectFilter();
    } else if (currentFilter.type == 'multiselect') {
      return _buildMultiSelectFilter();
    } else if (currentFilter.type == 'number') {
      return _buildNumberFilter();
    } else {
      return _buildTextFilter();
    }
  }

  Widget _buildSelectFilter() {
    final theme = Theme.of(context);
    List<FilterOption> options = currentFilter.options ?? [];

    // If no options but has validation (e.g., year filter), generate options from range
    if (options.isEmpty && currentFilter.validation != null) {
      final validation = currentFilter.validation!;
      if (validation.min != null && validation.max != null) {
        final step = validation.step ?? 1;
        options = [];
        for (int i = validation.max!; i >= validation.min!; i -= step) {
          options.add(FilterOption(value: i.toString(), label: i.toString()));
        }
      }
    }

    if (options.isEmpty) {
      return Center(
        child: Text('No options available', style: TextStyle(fontSize: 14.sp)),
      );
    }

    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
      children: [
        if (currentFilter.title != null && currentFilter.title!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.s8),
            child: Text(
              currentFilter.title!,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        if (currentFilter.subTitle != null &&
            currentFilter.subTitle!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.s16),
            child: Text(
              currentFilter.subTitle!,
              style: TextStyle(
                fontSize: 14.sp,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: options.length,
          separatorBuilder: (_, __) => verticalSpace(AppSizes.s12),
          itemBuilder: (context, index) {
            final option = options[index];
            final optionValue = option.value;
            final optionLabel = option.label ?? option.value;

            return FilterOptionCard(
              label: optionLabel,
              isSelected: _selectedOption == optionValue,
              onTap: () {
                setState(() {
                  _selectedOption = optionValue;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildMultiSelectFilter() {
    final theme = Theme.of(context);
    List<FilterOption> options = currentFilter.options ?? [];

    if (options.isEmpty) {
      return Center(
        child: Text('No options available', style: TextStyle(fontSize: 14.sp)),
      );
    }

    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
      children: [
        if (currentFilter.title != null && currentFilter.title!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.s8),
            child: Text(
              currentFilter.title!,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        if (currentFilter.subTitle != null &&
            currentFilter.subTitle!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.s16),
            child: Text(
              currentFilter.subTitle!,
              style: TextStyle(
                fontSize: 14.sp,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: options.length,
          separatorBuilder: (_, __) => verticalSpace(AppSizes.s12),
          itemBuilder: (context, index) {
            final option = options[index];
            final optionValue = option.value;
            final optionLabel = option.label ?? option.value;
            final isSelected = _selectedOptions.contains(optionValue);

            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedOptions.remove(optionValue);
                  } else {
                    _selectedOptions.add(optionValue);
                  }
                });
              },
              borderRadius: BorderRadius.circular(AppSizes.r16),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.s16,
                  vertical: AppSizes.s16,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        )
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.r16),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withValues(alpha: 0.1),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Checkbox
                    Icon(
                      isSelected
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank_rounded,
                      size: 22.sp,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.3,
                            ),
                    ),
                    SizedBox(width: AppSizes.s12),
                    // Label
                    Expanded(
                      child: Text(
                        optionLabel,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNumberFilter() {
    final validation = currentFilter.validation;

    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: AppSizes.s24),
        children: [
          Text(
            currentFilter.label,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          verticalSpace(AppSizes.s16),
          AppTextField(
            controller: _textController,
            hintText: currentFilter.label,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }

              final number = int.tryParse(value.trim());
              if (number == null) {
                return 'Please enter a valid number';
              }

              if (validation != null) {
                if (validation.min != null && number < validation.min!) {
                  return 'Minimum value is ${validation.min}';
                }
                if (validation.max != null && number > validation.max!) {
                  return 'Maximum value is ${validation.max}';
                }
              }

              return null;
            },
          ),
          if (validation != null) ...[
            verticalSpace(AppSizes.s8),
            Text(
              'Range: ${validation.min} - ${validation.max}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTextFilter() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: AppSizes.s24),
        children: [
          Text(
            currentFilter.label,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          verticalSpace(AppSizes.s16),
          AppTextField(
            controller: _textController,
            hintText: currentFilter.label,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
