import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/features/create_ad/presentation/cubit/create_ad/create_ad_cubit.dart';
import 'package:channels/features/create_ad/presentation/cubit/create_ad/create_ad_state.dart';

/// Create Ad Details Form View - Collect title, description, price, and phone number
class CreateAdDetailsView extends StatefulWidget {
  final Map<String, dynamic> formData;
  final String categoryId; // Subcategory ID (leaf node)
  final String parentCategoryId; // Parent category ID (not used in API)
  final String rootCategoryId; // Root category ID (used in API as category_id)
  final List<File> images;

  const CreateAdDetailsView({
    super.key,
    required this.formData,
    required this.categoryId,
    required this.parentCategoryId,
    required this.rootCategoryId,
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _handleSubmit(BuildContext context, CreateAdState state) {
    // Prevent multiple submissions
    if (state is CreateAdLoading) return;

    if (_formKey.currentState?.validate() ?? false) {
      debugPrint('📋 Submitting ad...');
      debugPrint('📋 Title: ${_titleController.text.trim()}');
      debugPrint('📋 Description: ${_descriptionController.text.trim()}');
      debugPrint('📋 Price: ${_priceController.text.trim()}');
      debugPrint('📋 Root Category ID (for API): ${widget.rootCategoryId}');
      debugPrint('📋 Subcategory ID (leaf): ${widget.categoryId}');
      debugPrint('📋 Form Data (attributes): ${widget.formData}');
      debugPrint('📋 Images count: ${widget.images.length}');

      // TODO: Get actual user country code from auth state/preferences
      const countryCode = 'JO'; // Default to Jordan for now

      context.read<CreateAdCubit>().createAd(
        categoryId: widget.rootCategoryId, // ROOT category for API
        subcategoryId: widget.categoryId, // Subcategory (leaf node)
        countryCode: countryCode,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        images: widget.images,
        attributes: widget.formData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => CreateAdCubit(createAdUseCase: sl()),
      child: BlocListener<CreateAdCubit, CreateAdState>(
        listener: (context, state) {
          if (state is CreateAdLoading) {
            // Show loading indicator
            debugPrint('📋 Creating ad...');
          } else if (state is CreateAdSuccess) {
            debugPrint('📋 Ad created successfully! ID: ${state.adId}');
            AppToast.success(context, title: 'Ad posted successfully!');
            // Navigate back to home or ad details
            context.go('/home');
          } else if (state is CreateAdFailure) {
            debugPrint('📋 Failed to create ad: ${state.message}');
            AppToast.error(context, title: state.message);
          }
        },
        child: BlocBuilder<CreateAdCubit, CreateAdState>(
          builder: (context, state) {
            final isLoading = state is CreateAdLoading;

            return Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              appBar: const AppAppBar(
                title: 'Ad Details',
                showBackButton: true,
              ),
              body: SafeArea(
                bottom: false,
                child: GradientOverlay(
                  bottomWidget: Padding(
                    padding: EdgeInsets.all(AppSizes.s16),
                    child: AppButton(
                      text: isLoading ? 'Posting...' : 'Post Ad',
                      onPressed: () => _handleSubmit(context, state),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.all(AppSizes.s16),
                      children: [
                        // Info banner
                        Container(
                          padding: EdgeInsets.all(AppSizes.s12),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withValues(
                              alpha: 0.3,
                            ),
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

                        SizedBox(
                          height: AppSizes.s80,
                        ), // Extra padding for gradient
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
