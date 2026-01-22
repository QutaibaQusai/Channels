import 'package:flutter/material.dart';

/// Reusable pull-to-refresh wrapper widget
/// Wraps any scrollable widget with pull-to-refresh functionality
class RefreshWrapper extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const RefreshWrapper({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: colorScheme.primary,
      backgroundColor: colorScheme.surface,
      child: child,
    );
  }
}
