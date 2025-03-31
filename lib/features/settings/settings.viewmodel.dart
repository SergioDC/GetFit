import 'package:get_it/get_it.dart';

import '../../common/data/change_notifier_custom.dart';
import '../log/log.service.dart';
import 'settings.dart';
import 'settings.repository.dart';

class SettingsViewModel extends ChangeNotifierCustom {
  final SettingsRepository settingsRepository;
  LogService log = GetIt.instance<LogService>();

  Settings settings = Settings();
  Settings get _s => settings;
  String? get versionLabel => _versionLabel;
  set versionLabel(String? value) {
    _versionLabel = value;
    notifyListeners();
  }

  String? _versionLabel;

  SettingsViewModel({required this.settingsRepository}) {
    log.logInfo('Initializing SettingsRepository.');
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    updateState(loading: true);

    try {
      log.logInfo('Loading settings from repository.');
      settings = await settingsRepository.loadSettings();
    } catch (e) {
      log.logError(
        'Failed to load settings data.',
        Exception(e),
      );
      setError('Failed to load settings data: $e');
    } finally {
      updateState();
    }
  }

  Future<void> updateSettings({
    int? logMaxLinesThreshold,
    int? logMaxLinesRecovery,
    LogLevel? logLevel,
    bool? devEnableDeveloperOptions,
    String? imgBackground,
    bool? isDarkTheme,
    String? fontFamily,
    int? fontSize,
  }) async {
    _s.logMaxLinesThreshold = logMaxLinesThreshold ?? _s.logMaxLinesThreshold;
    _s.logMaxLinesRecovery = logMaxLinesRecovery ?? _s.logMaxLinesRecovery;
    _s.logLevel = logLevel ?? _s.logLevel;
    _s.devEnableDeveloperOptions =
        devEnableDeveloperOptions ?? _s.devEnableDeveloperOptions;
    _s.imgBackground = imgBackground ?? _s.imgBackground;
    _s.isDarkTheme = isDarkTheme ?? _s.isDarkTheme;
    _s.fontFamily = fontFamily ?? _s.fontFamily;
    _s.fontSize = fontSize ?? _s.fontSize;

    updateState();

    try {
      await settingsRepository.saveSettings(settings);
      log.logInfo('Settings updated successfully.');
    } catch (e) {
      log.logError('Failed to save settings.', Exception(e));
      setError('Failed to save settings: $e');
      updateState();
    }
  }
}
