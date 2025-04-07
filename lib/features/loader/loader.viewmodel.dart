import 'package:get_it/get_it.dart';

import '../../common/data/change_notifier_custom.dart';
import '../log/log.service.dart';
import 'loader.dart';

class LoaderViewModel extends ChangeNotifierCustom {
  // We instantiate Loader to manage settings for printing statistics,
  // which aids in conditional logging for debugging purposes.
  final loader = Loader();

  // We obtain the LogService instance via dependency injection to maintain consistent logging across the app.
  final log = GetIt.instance<LogService>();

  // The constructor is kept simple to allow for future repository injections,
  // and it logs the initialization of the view model along with its loader.
  LoaderViewModel() {
    log.logData('LoaderViewModel initialized with Loader instance', loader);
  }

  // This method prints data statistics using logs.
  // Logging the label helps us confirm the context in which statistics are being reported.
  void printDataStatistics(String label) {
    log.logData('printDataStatistics called with label', label);
    log.logInfo('----- DATA STATISTICS -----');
    log.logInfo('----- [$label]');
    // The following logs are placeholders for repository data counts and can be enabled when repositories are integrated.
    // log.logInfo('Library count: ${libraryRepository.rawDataCount()}');
    // log.logInfo('Novel count:   ${novelRepository.rawDataCount()}');
    // log.logInfo('Browser Filters count:   ${filtersRepitory.rawDataCount()}');
    log.logInfo('---------------------------');
  }

  // This asynchronous method initializes application data.
  // It updates the UI state to reflect loading progress and handles errors to maintain robust user feedback.
  Future<void> initializeAppData() async {
    setInitializeState();

    try {
      // The following commented code sections are placeholders for future repository access and data loading.
      // They are structured this way to provide a template for integrating actual data sources later.
      // log.logInfo('Obtaining access to library.');
      // var libraryViewModel = GetIt.instance<LibraryViewModel>();

      // if (loader.printDataStatistics) {
      //   log.logInfo('Printing statistics.');
      //   printDataStatistics('Stored Data');
      // }

      // log.logInfo('Loading library.');
      // await libraryViewModel.loadLibrary();
    } catch (e) {
      // Logging the error with context here is crucial for troubleshooting failures during data initialization.
      log.logError('Failed to intialize application data.', Exception(e));
      setErrorState('Failed to intialize application data: $e');
    } finally {
      // The state update in the finally block ensures that the UI is refreshed regardless of success or failure,
      // thus maintaining a consistent user experience.
      setReadyState();
    }
  }
}
