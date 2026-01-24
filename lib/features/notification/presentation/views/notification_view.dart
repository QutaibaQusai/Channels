import 'package:flutter/material.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';

/// Notification view - User notifications list
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppAppBar(
        title: 'Notifications',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Notifications View - Coming Soon'),
      ),
    );
  }
}
