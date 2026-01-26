import 'package:flutter/material.dart';

/// App Switch - Reusable switch with consistent styling
class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;

  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? colorScheme.primary,
      activeTrackColor: activeColor ?? colorScheme.primary,
    );
  }
}
