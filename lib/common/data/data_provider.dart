import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/loader/loader.viewmodel.dart';
import '../../features/log/log.service.dart';
import '../../features/settings/settings.viewmodel.dart';
import 'service_locator.dart';

class DataProvider extends StatelessWidget {
  const DataProvider({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    debugPrint('Building DataProvider for app context');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<LogService>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<SettingsViewModel>(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<BookcaseViewModel>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<BrowserViewModel>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<LibraryViewModel>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<NovelViewModel>(),
        // ),
        ChangeNotifierProvider(
          create: (_) => getIt<LoaderViewModel>(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<FiltersViewModel>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<ChapterViewModel>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => getIt<NovelSourceViewModel>(),
        // ),
      ],
      child: child,
    );
  }
}
