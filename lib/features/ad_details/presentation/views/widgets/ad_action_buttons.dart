import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';

/// Context-aware action buttons (Contact for public, Edit for owner)
class AdActionButtons extends StatelessWidget {
  final AdViewMode mode;
  final String phoneNumber;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onPublish;

  const AdActionButtons({
    super.key,
    required this.mode,
    required this.phoneNumber,
    this.onEdit,
    this.onDelete,
    this.onPublish,
  });

  Future<void> _makePhoneCall(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        AppToast.error(context, title: 'Could not launch phone dialer');
      }
    }
  }

  Future<void> _sendWhatsApp(BuildContext context) async {
    final cleanNumber = phoneNumber.replaceAll('+', '');
    final uri = Uri.parse('https://wa.me/$cleanNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        AppToast.error(context, title: 'Could not launch WhatsApp');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline, width: 1)),
      ),
      child: _buildButtons(context, l10n, colorScheme),
    );
  }

  Widget _buildButtons(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    switch (mode) {
      case AdViewMode.public:
        return Row(
          children: [
            // Call button
            Expanded(
              child: Container(
                color: colorScheme.primary,
                child: _ActionButton(
                  iconWidget: Icon(
                    LucideIcons.phone,
                    size: 20.sp,
                    color: colorScheme.onPrimary,
                  ),
                  label: l10n.adDetailsCall,
                  onTap: () => _makePhoneCall(context),
                  isPrimary: true,
                ),
              ),
            ),

            horizontalSpace(12.w),

            // WhatsApp button
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: AppSizes.screenPaddingH),
                child: _ActionButton(
                  iconWidget: SvgPicture.asset(
                    'assets/icons/whatsapp.svg',
                    width: 20.sp,
                    height: 20.sp,
                    colorFilter: ColorFilter.mode(
                      colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: l10n.adDetailsWhatsApp,
                  onTap: () => _sendWhatsApp(context),
                  isPrimary: false,
                ),
              ),
            ),
          ],
        );

      case AdViewMode.myAd:
        return Row(
          children: [
            // Edit button (Primary)
            Expanded(
              child: Container(
                color: colorScheme.primary,
                child: _ActionButton(
                  iconWidget: Icon(
                    LucideIcons.edit,
                    size: 20.sp,
                    color: colorScheme.onPrimary,
                  ),
                  label: 'Edit Ad', // TODO: Localize
                  onTap: onEdit ?? () {},
                  isPrimary: true,
                ),
              ),
            ),

            horizontalSpace(12.w),

            // Delete button
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: AppSizes.screenPaddingH),
                child: _ActionButton(
                  iconWidget: Icon(
                    LucideIcons.trash2,
                    size: 20.sp,
                    color: colorScheme.error,
                  ),
                  label: 'Delete', // TODO: Localize
                  onTap: onDelete ?? () {},
                  isPrimary: false,
                  textColor: colorScheme.error,
                ),
              ),
            ),
          ],
        );

      case AdViewMode.preview:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: _ActionButton(
            iconWidget: Icon(
              LucideIcons.upload,
              size: 20.sp,
              color: colorScheme.onPrimary,
            ),
            label: 'Publish Now', // TODO: Localize
            onTap: onPublish ?? () {},
            isPrimary: true,
          ),
        );
    }
  }
}

class _ActionButton extends StatelessWidget {
  final Widget iconWidget;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final Color? textColor;

  const _ActionButton({
    required this.iconWidget,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: AppSizes.buttonHeightLarge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            horizontalSpace(8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color:
                    textColor ??
                    (isPrimary ? colorScheme.onPrimary : colorScheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
