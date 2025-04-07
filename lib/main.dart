import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'common/theme/app_theme.dart';
import 'common/config/configuration.dart';
import 'common/data/data.dart';
import 'common/data/data_provider.dart';
import 'common/data/service_locator.dart';
import 'features/loader/loader.view.dart';
import 'features/log/log.service.dart';
import 'features/settings/settings.viewmodel.dart';

void main() async {
  // Ensure that Flutter framework is fully initialized before further actions
  WidgetsFlutterBinding.ensureInitialized();
  // Log the start of service locator setup to track dependency injections initialization
  debugPrint('Initializing ServiceLocator');
  setupServiceLocator();

  // Acquire the logging service instance from the service locator for consistent logging
  var log = GetIt.instance<LogService>();
  log.logData('Acquired LogService instance', log);
  log.logInfo('Initializing Database');
  // Create the Data object which sets up the persistent storage; configuration may allow resetting data in development
  await Data.create(resetData: Configuration.devDeleteAllDataAtStart);
  log.logInfo('Running App with data context');
  // Launch the application wrapped with DataProvider to supply data context throughout the widget tree
  runApp(DataProvider(child: GetFit()));
}

class GetFit extends StatelessWidget {
  // We acquire the logging service instance to ensure that all components within this widget can record their states.
  GetFit({super.key});

  final LogService log = GetIt.instance<LogService>();

  // The build method sets up the core MaterialApp widget and initializes screen utility for responsive design.
  @override
  Widget build(BuildContext context) {
    log.logInfo('Building MaterialApp');
    log.logInfo('Home route: LoaderView');

    return ScreenUtilInit(
      // Configure the design size based on device viewport settings to support responsive layouts.
      designSize: Configuration.deviceViewportSize,
      builder:
          (_, __) => Consumer<SettingsViewModel>(
            // We use Consumer to rebuild the MaterialApp when user settings change, ensuring UI consistency with theme preferences.
            builder: (_, settingsViewModel, __) {
              // Instantiate AppTheme to obtain both light and dark themes for the application.
              var appTheme = AppTheme();
              log.logData('AppTheme instance created', appTheme);

              return MaterialApp(
                // Customize scroll behavior to support various input devices for improved cross-platform user experience.
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                    PointerDeviceKind.stylus,
                    PointerDeviceKind.unknown,
                  },
                ),
                // Remove debug banner for a cleaner presentation in release builds.
                debugShowCheckedModeBanner: false,
                // Set the application title for OS task switchers and app identification.
                title: 'GetFit',
                // Dynamically switch between light and dark themes based on user settings to improve accessibility and visual comfort.
                themeMode:
                    settingsViewModel.settings.isDarkTheme
                        ? ThemeMode.dark
                        : ThemeMode.light,
                theme: appTheme.light,
                darkTheme: appTheme.dark,
                // Set the home screen of the app to LoaderView, which handles the initial loading process.
                home: LoaderView(),
              );
            },
          ),
    );
  }
}
