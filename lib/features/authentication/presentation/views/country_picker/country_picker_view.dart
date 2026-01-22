import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/custom_app_bar.dart';
import 'package:channels/core/shared/widgets/search_bar_widget.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/authentication/data/models/country_model.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_state.dart';
import 'package:channels/core/shared/widgets/loading_widget.dart';
import 'package:channels/core/shared/widgets/error_widget.dart';
import 'package:channels/features/authentication/presentation/views/country_picker/widgets/countries_empty_widget.dart';
import 'package:channels/features/authentication/presentation/views/country_picker/widgets/country_list_item.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textExtension = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: l10n.countryPickerTitle,
        showBackButton: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingH,
                vertical: AppSizes.s16,
              ),
              child: SearchBarWidget(
                hintText: l10n.countryPickerSearchHint,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // Countries list
            Expanded(
              child: BlocBuilder<CountriesCubit, CountriesState>(
                builder: (context, state) {
                  if (state is CountriesLoading) {
                    return const LoadingWidget();
                  }

                  if (state is CountriesFailure) {
                    return ErrorStateWidget(
                      message: state.errorMessage,
                      onRetry: () {
                        context.read<CountriesCubit>().getCountries();
                      },
                    );
                  }

                  if (state is CountriesSuccess) {
                    final filteredCountries = _filterCountries(state.countries);

                    if (filteredCountries.isEmpty) {
                      return const CountriesEmptyWidget();
                    }

                    return ListView.separated(
                      padding: EdgeInsets.only(
                        left: AppSizes.screenPaddingH,
                        right: AppSizes.screenPaddingH,
                        bottom: 0,
                      ),
                      itemCount: filteredCountries.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1, color: textExtension.divider),
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return CountryListItem(
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
