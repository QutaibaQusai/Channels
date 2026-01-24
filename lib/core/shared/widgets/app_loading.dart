import 'package:flutter/material.dart';

/// Shared loading widget with circular progress indicator
/// Use this for all loading states across the app
class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
