import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Create Ad Details Form View - Collect title, description, price, and phone number
class CreateAdDetailsView extends StatefulWidget {
  final Map<String, dynamic> formData;
  final String categoryId;
  final List<File> images;

  const CreateAdDetailsView({
    super.key,
    required this.formData,
    required this.categoryId,
    required this.images,
  });

  @override
  State<CreateAdDetailsView> createState() => _CreateAdDetailsViewState();
}

class _CreateAdDetailsViewState extends State<CreateAdDetailsView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final adData = {
        ...widget.formData,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': _priceController.text.trim(),
        'phone': _phoneController.text.trim(),
        'categoryId': widget.categoryId,
      };

      debugPrint('📋 Final Ad Data: $adData');
      debugPrint('📋 Images count: ${widget.images.length}');

      // TODO: Call POST API to create ad
      AppToast.success(
        context,
        title: 'Ad data collected successfully!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const AppAppBar(
        title: 'Ad Details',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(AppSizes.s16),
            children: [
              // Info banner
              Container(
                padding: EdgeInsets.all(AppSizes.s12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: colorScheme.primary,
                      size: 20.sp,
                    ),
                    SizedBox(width: AppSizes.s8),
                    Expanded(
                      child: Text(
                        'Fill in the details below to complete your ad',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSizes.s24),

              // Title field
              Text(
                'Ad Title *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              AppTextField(
                controller: _titleController,
                hintText: 'Enter ad title',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Title must be at least 3 characters';
                  }
                  if (value.trim().length > 100) {
                    return 'Title must not exceed 100 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSizes.s20),

              // Description field
              Text(
                'Description *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              AppTextField(
                controller: _descriptionController,
                hintText: 'Enter detailed description',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description is required';
                  }
                  if (value.trim().length < 10) {
                    return 'Description must be at least 10 characters';
                  }
                  if (value.trim().length > 1000) {
                    return 'Description must not exceed 1000 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSizes.s20),

              // Price field
              Text(
                'Price *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              AppTextField(
                controller: _priceController,
                hintText: 'Enter price',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Price is required';
                  }
                  final price = double.tryParse(value.trim());
                  if (price == null) {
                    return 'Please enter a valid number';
                  }
                  if (price < 0) {
                    return 'Price cannot be negative';
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSizes.s20),

              // Phone number field
              Text(
                'Contact Phone Number *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSizes.s4),
              Text(
                'Alternative phone number for buyers to contact you',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: AppSizes.s8),
              AppTextField(
                controller: _phoneController,
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  // Remove any non-digit characters for validation
                  final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                  if (digitsOnly.length < 10) {
                    return 'Phone number must be at least 10 digits';
                  }
                  if (digitsOnly.length > 15) {
                    return 'Phone number must not exceed 15 digits';
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSizes.s32),

              // Submit button
              AppButton(
                text: 'Post Ad',
                onPressed: _handleSubmit,
              ),

              SizedBox(height: AppSizes.s16),
            ],
          ),
        ),
      ),
    );
  }
}