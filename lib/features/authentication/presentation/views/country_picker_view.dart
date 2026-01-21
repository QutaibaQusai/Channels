import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/core/shared/widgets/custom_app_bar.dart';
import 'package:channels/features/authentication/data/models/country_model.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_state.dart';

/// Country picker view - User selects their country
class CountryPickerView extends StatefulWidget {
  const CountryPickerView({super.key});

  @override
  State<CountryPickerView> createState() => _CountryPickerViewState();
}

class _CountryPickerViewState extends State<CountryPickerView> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<CountriesCubit>().getCountries();
  }

  List<CountryModel> _filterCountries(List<CountryModel> countries) {
    if (_searchQuery.isEmpty) return countries;
    return countries.where((country) {
      return country.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          country.dialingCode.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(
        title: 'Select Country',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingH,
                vertical: AppSizes.s16,
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search country...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textHintLight,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondaryLight,
                    size: AppSizes.icon24,
                  ),
                  filled: true,
                  fillColor: AppColors.surfaceLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                    borderSide: BorderSide(color: AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                    borderSide: BorderSide(color: AppColors.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.s16,
                    vertical: AppSizes.s12,
                  ),
                ),
              ),
            ),

            // Countries list
            Expanded(
              child: BlocBuilder<CountriesCubit, CountriesState>(
                builder: (context, state) {
                  if (state is CountriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is CountriesFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: AppSizes.icon48,
                            color: AppColors.error,
                          ),
                          verticalSpace(AppSizes.s16),
                          Text(
                            'Failed to load countries',
                            style: AppTypography.titleMedium,
                          ),
                          verticalSpace(AppSizes.s8),
                          Text(
                            state.errorMessage,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is CountriesSuccess) {
                    final filteredCountries = _filterCountries(state.countries);

                    if (filteredCountries.isEmpty) {
                      return Center(
                        child: Text(
                          'No countries found',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.screenPaddingH,
                      ),
                      itemCount: filteredCountries.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: AppColors.dividerLight,
                      ),
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return _CountryListItem(
                          country: country,
                          onTap: () {
                            Navigator.pop(context, country);
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryListItem extends StatelessWidget {
  final CountryModel country;
  final VoidCallback onTap;

  const _CountryListItem({
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
        child: Row(
          children: [
            // Country flag
            SvgPicture.network(
              country.flagUrl,
              width: AppSizes.icon32,
              height: AppSizes.icon32,
              placeholderBuilder: (context) => Container(
                width: AppSizes.icon32,
                height: AppSizes.icon32,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.flag,
                  size: AppSizes.icon20,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ),

            SizedBox(width: AppSizes.s12),

            // Country name and code
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace(AppSizes.s4),
                  Text(
                    country.placeholder,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),

            // Dialing code
            Text(
              country.dialingCode,
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
