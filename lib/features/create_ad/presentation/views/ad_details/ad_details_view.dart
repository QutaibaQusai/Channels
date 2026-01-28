import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/create_ad/presentation/cubit/create_ad/create_ad_cubit.dart';
import 'package:channels/features/create_ad/presentation/cubit/create_ad/create_ad_state.dart';
import 'package:channels/features/create_ad/presentation/views/ad_details/widgets/title_field.dart';
import 'package:channels/features/create_ad/presentation/views/ad_details/widgets/description_field.dart';
import 'package:channels/features/create_ad/presentation/views/ad_details/widgets/price_field.dart';

/// Create Ad Details Form View - Collect title, description, price
class CreateAdDetailsView extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Map<String, String> displayData;
  final String categoryId; // Subcategory ID (leaf node)
  final String parentCategoryId; // Parent category ID (not used in API)
  final String rootCategoryId; // Root category ID (used in API as category_id)
  final List<File> images;

  const CreateAdDetailsView({
    super.key,
    required this.formData,
    required this.displayData,
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

      context.pushNamed(
        RouteNames.createAdReview,
        extra: {
          'formData': widget.formData,
          'displayData': widget.displayData,
          'categoryId': widget.categoryId,
          'parentCategoryId': widget.parentCategoryId,
          'rootCategoryId': widget.rootCategoryId,
          'images': widget.images,
          'title': _titleController.text.trim(),
          'description': _descriptionController.text.trim(),
          'price': double.parse(_priceController.text.trim()),
          'countryCode': countryCode,
        },
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
            debugPrint('📋 Creating ad...');
          } else if (state is CreateAdSuccess) {
            debugPrint('📋 Ad created successfully! ID: ${state.adId}');
            AppToast.success(context, title: 'Ad posted successfully!');
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
                      text: isLoading ? 'Processing...' : 'Review Ad',
                      onPressed: () => _handleSubmit(context, state),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.all(AppSizes.s16),
                      children: [
                        // Title field
                        TitleField(
                          controller: _titleController,
                          colorScheme: colorScheme,
                        ),

                        verticalSpace(AppSizes.s20),

                        // Description field
                        DescriptionField(
                          controller: _descriptionController,
                          colorScheme: colorScheme,
                        ),

                        verticalSpace(AppSizes.s20),

                        // Price field
                        PriceField(
                          controller: _priceController,
                          colorScheme: colorScheme,
                        ),

                        verticalSpace(AppSizes.s80), // Extra padding for gradient
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
