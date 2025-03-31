import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../../common/data/data.dart';
import '../log/log.service.dart';
import 'settings.dart';

class SettingsRepository {
  LogService log = GetIt.instance<LogService>();

  SettingsRepository();

  Future<int> rawDataCount() async {
    int count = await Data.settingsBox.count();
    log.logInfo('Counting settings: $count');
    return count;
  }

  Future<void> saveSettings(Settings settings) async {
    log.logInfo('Saving settings to box.');
    Data.settingsBox.put(settings); // Saves or updates the settings
  }

  Future<Settings> loadSettings() async {
    final settingList = await Data.settingsBox.where().findAll();
    log.logInfo('Fetching settings: ${settingList.length} from box.');
    Settings settings = Settings();
    if (settingList.isEmpty) {
      await saveSettings(settings);
      log.logInfo('No settings found. Creating a new one.');
    } else {
      settings = settingList.first;
      log.logInfo('Found settings with Id${settings.id}');
    }

    return settings;
  }
}
