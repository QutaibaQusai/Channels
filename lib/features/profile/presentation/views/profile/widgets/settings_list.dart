import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:channels/features/profile/presentation/views/profile/widgets/settings_tile.dart';
import 'package:channels/features/profile/presentation/views/profile/widgets/settings_toggle_tile.dart';
import 'package:channels/features/profile/presentation/views/profile/widgets/language_sheet.dart';
import 'package:channels/features/profile/presentation/views/profile/widgets/logout_sheet.dart';

/// Settings list with all setting tiles
class SettingsList extends StatelessWidget {
  final bool doNotDisturb;
  final ValueChanged<bool> onDoNotDisturbChanged;

  const SettingsList({
    super.key,
    required this.doNotDisturb,
    required this.onDoNotDisturbChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    return Column(
      children: [
        // Language
        SettingsTile(
          icon: LucideIcons.languages,
          title: l10n.settingsLanguage,
          value: locale.languageCode == 'ar' ? 'العربية' : 'English',
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => const LanguageSheet(),
            );
          },
        ),

        // Do Not Disturb (toggle)
        SettingsToggleTile(
          icon: LucideIcons.bellOff,
          title: l10n.settingsDoNotDisturb,
          subtitle: l10n.settingsDoNotDisturbSubtitle,
          value: doNotDisturb,
          onChanged: onDoNotDisturbChanged,
        ),

        // Help Center
        SettingsTile(
          icon: LucideIcons.helpCircle,
          title: l10n.settingsHelpCenter,
          onTap: () {
            context.pushNamed(
              RouteNames.webview,
              extra: {
                'title': l10n.settingsHelpCenter,
                'url': 'https://support.google.com', // Test URL
              },
            );
          },
        ),

        // Privacy Policy
        SettingsTile(
          icon: LucideIcons.shield,
          title: l10n.settingsPrivacyPolicy,
          onTap: () {
            context.pushNamed(
              RouteNames.webview,
              extra: {
                'title': l10n.settingsPrivacyPolicy,
                'url': 'https://policies.google.com/privacy', // Test URL
              },
            );
          },
        ),

        // Terms of Service
        SettingsTile(
          icon: LucideIcons.fileText,
          title: l10n.settingsTermsOfService,
          onTap: () {
            context.pushNamed(
              RouteNames.webview,
              extra: {
                'title': l10n.settingsTermsOfService,
                'url': 'https://policies.google.com/terms', // Test URL
              },
            );
          },
        ),

        // Sign Out
        SettingsTile(
          icon: LucideIcons.logOut,
          title: l10n.settingsSignOut,
          isDestructive: true,
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => const LogoutSheet(),
            );
          },
        ),
      ],
    );
  }
}
