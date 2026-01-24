import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Contact button widget - fixed at the bottom for calling/messaging seller
class AdContactButton extends StatelessWidget {
  final String phoneNumber;

  const AdContactButton({super.key, required this.phoneNumber});

  Future<void> _makePhoneCall(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch phone dialer')),
        );
      }
    }
  }

  Future<void> _sendWhatsApp(BuildContext context) async {
    // Remove + from phone number for WhatsApp
    final cleanNumber = phoneNumber.replaceAll('+', '');
    final uri = Uri.parse('https://wa.me/$cleanNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch WhatsApp')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Call button
            Expanded(
              child: _ContactActionButton(
                icon: LucideIcons.phone,
                label: l10n.adDetailsCall,
                onTap: () => _makePhoneCall(context),
                isPrimary: false,
              ),
            ),

            SizedBox(width: 12.w),

            // WhatsApp button
            Expanded(
              child: _ContactActionButton(
                icon: LucideIcons.messageCircle,
                label: l10n.adDetailsWhatsApp,
                onTap: () => _sendWhatsApp(context),
                isPrimary: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ContactActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.buttonHeightLarge,
        decoration: BoxDecoration(
          color: isPrimary
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.rFull),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isPrimary ? colorScheme.onPrimary : colorScheme.onSurface,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
