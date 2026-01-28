import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/shared/widgets/app_selector_field.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:channels/features/profile/presentation/views/profile_edit/widgets/profile_edit_avatar.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/domain/entities/country_entity.dart';
import 'package:channels/features/authentication/domain/usecases/get_countries_usecase.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';

class ProfileEditForm extends StatefulWidget {
  final Profile profile;
  final bool isUpdating;

  const ProfileEditForm({
    super.key,
    required this.profile,
    required this.isUpdating,
  });

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _countryController;

  String? _selectedCountryCode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.displayName);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _dobController = TextEditingController(
      text: widget.profile.dateOfBirth ?? '',
    );
    _countryController = TextEditingController();
    _selectedCountryCode = widget.profile.countryCode;
    _loadCountryName();
  }

  Future<void> _loadCountryName() async {
    if (_selectedCountryCode == null || _selectedCountryCode!.isEmpty) {
      return;
    }

    try {
      final l10n = AppLocalizations.of(context)!;
      final countries = await sl<GetCountriesUseCase>()(
        languageCode: l10n.localeName,
      );

      final country = countries.firstWhere(
        (c) => c.code == _selectedCountryCode,
        orElse: () => countries.first,
      );

      if (mounted) {
        setState(() {
          _countryController.text = country.name;
        });
      }
    } catch (e) {
      // Silently fail - user can still select a country
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _selectCountry(BuildContext context) async {
    final selectedCountry = await context.push<CountryEntity>(
      RouteNames.selectCountry,
    );
    if (selectedCountry != null && mounted) {
      setState(() {
        _countryController.text = selectedCountry.name;
        _selectedCountryCode = selectedCountry.code;
      });
    }
  }

  Future<void> _selectDate() async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    // Initial date handling
    DateTime initialDate;
    if (_dobController.text.isNotEmpty) {
      initialDate =
          DateTime.tryParse(_dobController.text) ??
          DateTime.now().subtract(const Duration(days: 365 * 18));
    } else {
      initialDate = DateTime.now().subtract(const Duration(days: 365 * 18));
    }

    DateTime selectedDate = initialDate;

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
                        setState(() {
                          _dobController.text =
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

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      final l10n = AppLocalizations.of(context)!;

      context.read<ProfileCubit>().submitUpdateProfile(
        languageCode: l10n.localeName,
        fullName: _nameController.text,
        dob: _dobController.text,
        countryCode: _selectedCountryCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textExtension = theme.extension<AppColorsExtension>()!;

    return GradientOverlay(
      bottomWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
        child: AppButton(
          text: l10n.profileEditSave,
          onPressed: _saveProfile,
          isLoading: widget.isUpdating,
        ),
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.screenPaddingH,
            vertical: AppSizes.s24,
          ),
          children: [
            // Avatar
            ProfileEditAvatar(profile: widget.profile),

            verticalSpace(32.h),

            // Name
            Text(
              l10n.profileEditName,
              style: theme.textTheme.labelLarge?.copyWith(
                color: textExtension.textSecondary,
              ),
            ),
            verticalSpace(8.h),
            AppTextField(
              controller: _nameController,
              hintText: l10n.profileEditName,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.registerNameRequired;
                }
                return null;
              },
            ),

            verticalSpace(16.h),

            // Phone (Read only)
            Text(
              l10n.profileEditPhone,
              style: theme.textTheme.labelLarge?.copyWith(
                color: textExtension.textSecondary,
              ),
            ),
            verticalSpace(8.h),
            AppTextField(
              controller: _phoneController,
              hintText: l10n.profileEditPhone,
              readOnly: true,
              suffixIcon: const Icon(LucideIcons.lock, size: 16),
            ),
            verticalSpace(8.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                l10n.profileEditContactSupportPhone,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textExtension.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ),

            verticalSpace(16.h),

            // Date of Birth
            Text(
              l10n.profileDateOfBirth,
              style: theme.textTheme.labelLarge?.copyWith(
                color: textExtension.textSecondary,
              ),
            ),
            verticalSpace(8.h),
            AppTextField(
              controller: _dobController,
              hintText: l10n.profileDateOfBirth,
              readOnly: true,
              onTap: _selectDate,
              prefixIcon: const Icon(LucideIcons.calendar),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.registerDateOfBirthRequired;
                }
                return null;
              },
            ),

            verticalSpace(16.h),

            // Country
            Text(
              l10n.registerCountryLabel,
              style: theme.textTheme.labelLarge?.copyWith(
                color: textExtension.textSecondary,
              ),
            ),
            verticalSpace(8.h),
            AppSelectorField(
              controller: _countryController,
              hintText: l10n.registerCountryPlaceholder,
              onTap: () => _selectCountry(context),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.registerCountryRequired;
                }
                return null;
              },
            ),

            verticalSpace(100.h), // Spacing for bottom button
          ],
        ),
      ),
    );
  }
}
