import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../features/loader/loader.viewmodel.dart';
import '../../features/log/log.service.dart';
import '../../features/login/login.viewmodel.dart';
import '../../features/settings/settings.repository.dart';
import '../../features/settings/settings.viewmodel.dart';
//import '../constants/urls.dart';
//import '../services/network_service.dart';

// Initialize
final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Register LoggingService as a singleton
  debugPrint('Adding LogService to service locator');
  var logService = LogService();
  getIt.registerSingleton<LogService>(logService);

  //final networkService = NetworkService(baseUrl: Urls.baseUrl);
  // final libraryRepository = LibraryRepository();
  // final novelRepository = NovelRepository();
  // final filtersRepository = FiltersRepository();

  logService.logInfo('Adding ViewModels to service locator');
  logService.logInfo('Adding SettingsViewModel');
  getIt.registerSingleton<SettingsViewModel>(
    SettingsViewModel(settingsRepository: SettingsRepository()),
  );
  logService.logInfo('Adding LoginViewModel');
  getIt.registerSingleton<LoginViewModel>(LoginViewModel());
  // getIt.registerSingleton<LibraryViewModel>(
  //   LibraryViewModel(
  //     libraryRepository: libraryRepository,
  //     novelRepository: novelRepository,
  //   ),
  // );
  // getIt.registerSingleton<NovelViewModel>(
  //   NovelViewModel(
  //     networkService: networkService,
  //     novelRepository: novelRepository,
  //   ),
  // );
  logService.logInfo('Adding LoaderViewModel');
  getIt.registerSingleton<LoaderViewModel>(
    LoaderViewModel(
      // libraryRepository: libraryRepository,
      // novelRepository: novelRepository,
      // filtersRepitory: filtersRepository,
    ),
  );
  // getIt.registerSingleton<FiltersViewModel>(
  //   FiltersViewModel(filtersRepository: filtersRepository),
  // );
  // getIt.registerSingleton<ChapterViewModel>(
  //   ChapterViewModel(networkService: networkService),
  // );
  // getIt.registerSingleton<BrowserViewModel>(
  //   BrowserViewModel(networkService: networkService),
  // );
  // getIt.registerSingleton<NovelSourceViewModel>(
  //   NovelSourceViewModel(),
  // );
}
