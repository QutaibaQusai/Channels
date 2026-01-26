import 'package:flutter/material.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/l10n/app_localizations.dart';

class MyAdsView extends StatelessWidget {
  const MyAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppAppBar(title: l10n.settingsMyAds, showBackButton: true),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
