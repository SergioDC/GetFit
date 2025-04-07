import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../features/log/log.service.dart';
import '../../features/settings/settings.dart';
import '../constants/urls.dart';

sealed class Data {
  static Isar? store;

  // static Box<Novel> get novelBox => _store!.box<Novel>();
  // static Box<Library> get libraryBox => _store!.box<Library>();
  // static Box<Filters> get listFiltersBox => _store!.box<Filters>();
  static IsarCollection<Settings> get settingsBox => store!.settings;

  static Directory? directory;

  static Future<void> _initializeDatabase() async {
    directory = Directory(
      p.join((await getApplicationDocumentsDirectory()).path, Urls.dbFolder),
    );
    var dirExists = await directory!.exists();
    if (!dirExists) {
      await directory!.create();
    }
  }

  static Future<void> create({bool resetData = false}) async {
    var log = GetIt.instance<LogService>();
    if (store != null && store!.isOpen) {
      log.logInfo('The database is open. Closing it before continuing');
      await store!.close();
    }

    log.logInfo('Initializing database');
    await _initializeDatabase();
    if (directory == null) {
      log.logInfo('Error. Could not initialize data directory.');
    }

    log.logData('Data directory', directory!.path);
    if (resetData) {
      log.logInfo('Reset data flag is true. Resetting database');
      await _deleteDatabase();
    }
    log.logInfo('Opening data storage');
    store = await Isar.open(
      [SettingsSchema],
      name: 'getfit',
      directory: directory!.path,
      inspector: true,
    ); // Specify writable directory
  }

  static Future<void> resetDatabase() async {
    await create(resetData: true);
  }

  static Future<void> _deleteDatabase() async {
    var log = GetIt.instance<LogService>();
    log.logInfo('Deleting database');
    log.logData('Deleting app database', directory!.path);
    if (await directory!.exists()) {
      await directory!.delete(recursive: true);
    }
  }
}
