import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Update Ad View - For editing existing ads
class UpdateAdView extends StatefulWidget {
  final AdDetails adDetails;

  const UpdateAdView({super.key, required this.adDetails});

  @override
  State<UpdateAdView> createState() => _UpdateAdViewState();
}

class _UpdateAdViewState extends State<UpdateAdView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.adDetails.title);
    _descriptionController = TextEditingController(
      text: widget.adDetails.description,
    );
    _priceController = TextEditingController(
      text: widget.adDetails.amount.toString(),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement update logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update functionality coming soon!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppAppBar(
        title: 'Update Ad', // TODO: Add localization
        showBackButton: true,
      ),
      body: GradientOverlay(
        bottomWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: AppButton(
            text: 'Update Ad', // TODO: Add localization
            onPressed: _handleUpdate,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Field
                Text(
                  l10n.labelTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(8.h),
                AppTextField(
                  controller: _titleController,
                  hintText: 'Enter title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                verticalSpace(24.h),

                // Price Field
                Text(
                  l10n.labelPrice,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(8.h),
                AppTextField(
                  controller: _priceController,
                  hintText: 'Enter price (${widget.adDetails.priceCurrency})',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                verticalSpace(24.h),

                // Description Field
                Text(
                  l10n.myAdDetailsSectionDescription,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(8.h),
                AppTextField(
                  controller: _descriptionController,
                  hintText: 'Enter description',
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                verticalSpace(24.h),

                // Category Info (Read-only)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category Information',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      verticalSpace(12.h),
                      _buildInfoRow(
                        l10n.labelCategory,
                        widget.adDetails.categoryName ??
                            widget.adDetails.categoryId,
                        theme,
                      ),
                      verticalSpace(8.h),
                      _buildInfoRow(
                        l10n.labelSubCategory,
                        widget.adDetails.subcategoryName ??
                            widget.adDetails.subcategoryId ??
                            'N/A',
                        theme,
                      ),
                      verticalSpace(8.h),
                      _buildInfoRow(
                        l10n.labelLocation,
                        widget.adDetails.countryCode,
                        theme,
                      ),
                    ],
                  ),
                ),
                verticalSpace(100.h), // Extra space for bottom button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
