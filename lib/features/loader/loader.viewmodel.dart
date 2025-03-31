import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../common/data/change_notifier_custom.dart';
import '../log/log.service.dart';
import 'loader.dart';

class LoaderViewModel extends ChangeNotifierCustom {
  // final LibraryRepository libraryRepository;
  // final NovelRepository novelRepository;
  // final FiltersRepository filtersRepitory;
  final loader = Loader();
  final log = GetIt.instance<LogService>();

  LoaderViewModel(
    // {required this.libraryRepository,
    // required this.novelRepository,
    // required this.filtersRepitory,}
  );

  void printDataStatistics(String label) {
    log.logInfo('');
    log.logInfo('----- DATA STATISTICS -----');
    log.logInfo('----- [$label]');
    // log.logInfo('Library count: ${libraryRepository.rawDataCount()}');
    // log.logInfo('Novel count:   ${novelRepository.rawDataCount()}');
    // log.logInfo('Browser Filters count:   ${filtersRepitory.rawDataCount()}');
    log.logInfo('---------------------------');
    log.logInfo('');
  }

  Future<void> initializeAppData(BuildContext context) async {
    updateState(loading: true);

    try {
      // log.logInfo('Obtaining access to library.');
      // var libraryViewModel = GetIt.instance<LibraryViewModel>();

      // if (loader.printDataStatistics) {
      //   log.logInfo('Printing statistics.');
      //   printDataStatistics('Stored Data');
      // }

      // log.logInfo('Loading library.');
      // await libraryViewModel.loadLibrary();
    } catch (e) {
      log.logError(
        'Failed to intialize application data.',
        Exception(e),
      );
      setError('Failed to intialize application data: $e');
    } finally {
      updateState();
    }
  }
}
