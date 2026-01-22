import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_theme.dart';
import 'package:channels/core/router/app_router.dart';
import 'package:channels/core/services/storage_service.dart';
import 'package:channels/core/services/theme_service.dart';
import 'package:channels/core/services/language_service.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure status bar to be visible
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  // Initialize storage service
  final storageService = StorageService();
  await storageService.init();

  runApp(
    ProviderScope(
      overrides: [storageServiceProvider.overrideWithValue(storageService)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize locale from storage after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(localeProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    // Set status bar style based on theme mode
    final brightness = themeMode == ThemeMode.dark
        ? Brightness.dark
        : themeMode == ThemeMode.light
            ? Brightness.light
            : MediaQuery.platformBrightnessOf(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        statusBarBrightness: brightness,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          key: ValueKey(locale.languageCode), // Force rebuild on locale change
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,

          // Theme Configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,

          // Localization Configuration (Official Flutter)
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          // Routing Configuration
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
