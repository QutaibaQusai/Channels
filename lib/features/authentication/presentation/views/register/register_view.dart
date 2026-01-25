import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

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
            color: colorScheme.surface,
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
                      color: textExtension.textSecondary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        l10n.commonCancel,
                        style: TextStyle(
                          color: textExtension.textSecondary,
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
                        l10n.commonDone,
                        style: TextStyle(
                          color: colorScheme.primary,
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
                        color: colorScheme.onSurface,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    backgroundColor: colorScheme.surface,
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          // Navigate to home after successful registration
          context.pushReplacement(RouteNames.home);
        } else if (state is RegisterFailure) {
          AppToast.error(context, title: state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: const AppAppBar(showBackButton: true),
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
                    l10n.registerTitle,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  verticalSpace(AppSizes.s12),

                  // Subtitle
                  Text(
                    l10n.registerSubtitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: textExtension.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  verticalSpace(AppSizes.s40),

                  // Name field
                  Text(
                    l10n.registerNameLabel,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(AppSizes.s8),
                  AppTextField(
                    controller: _nameController,
                    hintText: l10n.registerNamePlaceholder,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.registerNameRequired;
                      }
                      return null;
                    },
                  ),

                  verticalSpace(AppSizes.s24),

                  // Date of birth field
                  Text(
                    l10n.registerDateOfBirthLabel,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(AppSizes.s8),
                  AppTextField(
                    controller: _dateOfBirthController,
                    hintText: l10n.registerDateOfBirthPlaceholder,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.registerDateOfBirthRequired;
                      }
                      return null;
                    },
                  ),

                  const Spacer(),

                  // Register button
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return AppButton(
                        text: l10n.registerButton,
                        onPressed: _handleRegister,
                        isLoading: state is RegisterLoading,
                        backgroundColor: colorScheme.primary,
                        textColor: colorScheme.onPrimary,
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
