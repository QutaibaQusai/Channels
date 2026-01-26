import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_search_bar.dart';
import 'package:channels/core/shared/widgets/app_refresh_wrapper.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/features/authentication/domain/entities/country_entity.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/countries/countries_state.dart';
import 'package:channels/features/authentication/domain/usecases/get_countries_usecase.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/shared/widgets/app_empty_state.dart';
import 'package:channels/features/authentication/presentation/views/country_picker/widgets/select_country_list_item.dart';

/// Select Country View - Allows user to search and select a country
/// Returns the selected CountryEntity on pop
class SelectCountryView extends StatefulWidget {
  const SelectCountryView({super.key});

  @override
  State<SelectCountryView> createState() => _SelectCountryViewState();
}

class _SelectCountryViewState extends State<SelectCountryView> {
  String _searchQuery = '';

  List<CountryEntity> _filterCountries(List<CountryEntity> countries) {
    if (_searchQuery.isEmpty) return countries;
    return countries.where((country) {
      return country.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          country.dialCode.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textExtension = theme.extension<AppColorsExtension>()!;
    final locale = Localizations.localeOf(context);
    final languageCode = locale.languageCode;

    return BlocProvider(
      create: (context) => CountriesCubit(
        getCountriesUseCase: sl<GetCountriesUseCase>(),
        languageCode: languageCode,
      )..getCountries(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppAppBar(title: l10n.countryPickerTitle, showBackButton: true),
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
                child: AppSearchBar(
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
                      return const AppLoading();
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
                      final filteredCountries = _filterCountries(
                        state.countries,
                      );

                      if (filteredCountries.isEmpty) {
                        return AppEmptyState(
                          icon: Icons.search_off_outlined,
                          message: l10n.countryPickerNoResults,
                          subtitle: 'Try searching with a different keyword',
                        );
                      }

                      return AppRefreshWrapper(
                        onRefresh: () =>
                            context.read<CountriesCubit>().refreshCountries(),
                        child: ListView.separated(
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
                            return SelectCountryListItem(
                              country: country,
                              onTap: () {
                                Navigator.pop(context, country);
                              },
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
