import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/custom_app_bar.dart';
import 'package:channels/core/shared/widgets/custom_text_field.dart';
import 'package:channels/core/localization/app_localizations.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/register/register_state.dart';

/// Register view - New users complete their profile with name and date of birth
class RegisterView extends StatefulWidget {
  final String token;

  const RegisterView({super.key, required this.token});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now().subtract(
      const Duration(days: 365 * 18),
    );

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.r16),
              topRight: Radius.circular(AppSizes.r16),
            ),
          ),
          child: Column(
            children: [
              // Header with Cancel and Done buttons
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.textSecondaryLight.withOpacity(0.2),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'common.cancel'.tr(context),
                        style: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<RegisterCubit>().selectDate(selectedDate);
                        setState(() {
                          _dateOfBirthController.text =
                              "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'common.done'.tr(context),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Cupertino Date Picker
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    backgroundColor: Colors.white,
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate = newDate;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final dateOfBirth = _dateOfBirthController.text.trim();

      // Call register API with token
      context.read<RegisterCubit>().register(
        token: widget.token,
        name: name,
        dateOfBirth: dateOfBirth,
      );
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
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'register.namePlaceholder'.tr(context),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'register.nameRequired'.tr(context);
                      }
                      return null;
                    },
                  ),

                  verticalSpace(AppSizes.s24),

                  // Date of birth field
                  Text(
                    'register.dateOfBirthLabel'.tr(context),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                  verticalSpace(AppSizes.s8),
                  CustomTextField(
                    controller: _dateOfBirthController,
                    hintText: 'register.dateOfBirthPlaceholder'.tr(context),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'register.dateOfBirthRequired'.tr(context);
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
