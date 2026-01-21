import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/custom_app_bar.dart';
import 'package:channels/core/localization/app_localizations.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_state.dart';

/// Register view - New users complete their profile with name and address
class RegisterView extends StatefulWidget {
  final String token;

  const RegisterView({
    super.key,
    required this.token,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    debugPrint('🔵 Register button pressed');
    debugPrint('🔵 Token: ${widget.token}');

    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final address = _addressController.text.trim();

      debugPrint('🔵 Form validated successfully');
      debugPrint('🔵 Name: $name');
      debugPrint('🔵 Address: $address');

      // Call register API with token
      debugPrint('🔵 Calling register API...');
      context.read<RegisterCubit>().register(
            token: widget.token,
            name: name,
            address: address,
          );
    } else {
      debugPrint('🔴 Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          // Navigate to home after successful registration
          context.pushReplacement(RouteNames.home);
        } else if (state is RegisterFailure) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: const CustomAppBar(showBackButton: true),
        body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(AppSizes.s20),

                // Title
                Text(
                  'register.title'.tr(context),
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),

                verticalSpace(AppSizes.s12),

                // Subtitle
                Text(
                  'register.subtitle'.tr(context),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondaryLight,
                    height: 1.5,
                  ),
                ),

                verticalSpace(AppSizes.s40),

                // Name field
                Text(
                  'register.nameLabel'.tr(context),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                verticalSpace(AppSizes.s8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'register.namePlaceholder'.tr(context),
                    hintStyle: TextStyle(
                      color: AppColors.textSecondaryLight.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.s16,
                      vertical: AppSizes.s16,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimaryLight,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'register.nameRequired'.tr(context);
                    }
                    return null;
                  },
                ),

                verticalSpace(AppSizes.s24),

                // Address field
                Text(
                  'register.addressLabel'.tr(context),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                verticalSpace(AppSizes.s8),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'register.addressPlaceholder'.tr(context),
                    hintStyle: TextStyle(
                      color: AppColors.textSecondaryLight.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.s16,
                      vertical: AppSizes.s16,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimaryLight,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'register.addressRequired'.tr(context);
                    }
                    return null;
                  },
                ),

                const Spacer(),

                // Register button
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return AppButton(
                      text: 'register.registerButton'.tr(context),
                      onPressed: _handleRegister,
                      isLoading: state is RegisterLoading,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                    );
                  },
                ),

                verticalSpace(AppSizes.s32),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
