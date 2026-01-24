import 'package:flutter/material.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';

/// Profile view - User profile and settings
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppAppBar(
        title: 'Profile',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Profile View - Coming Soon'),
      ),
    );
  }
}
