import 'package:flutter/material.dart';

/// Loading state widget for countries
class CountriesLoadingWidget extends StatelessWidget {
  const CountriesLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
