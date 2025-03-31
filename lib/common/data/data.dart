import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
    if (store != null && store!.isOpen) {
      await store!.close();
    }

    await _initializeDatabase();
    if (directory == null) {
      debugPrint('Error. Could not initialize data directory.');
    }

    debugPrint('Data directory: ${directory!.path}');
    if (resetData) {
      await _deleteDatabase();
    }
    debugPrint('Opening data storage');
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
    debugPrint('Deleting app database from:');
    debugPrint('[${directory!.path}]');
    if (await directory!.exists()) {
      await directory!.delete(recursive: true);
    }
  }
}
