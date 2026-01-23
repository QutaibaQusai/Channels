import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:channels/channels_app.dart';
import 'package:channels/core/services/storage_service.dart';
import 'package:channels/core/services/theme_service.dart';
import 'package:channels/core/di/service_locator.dart';

/// Application entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure status bar to be visible
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  // Initialize service locator (dependency injection)
  await setupServiceLocator();

  // Initialize storage service
  final storageService = StorageService();
  await storageService.init();

  runApp(
    ProviderScope(
      overrides: [storageServiceProvider.overrideWithValue(storageService)],
      child: const ChannelsApp(),
    ),
  );
}
