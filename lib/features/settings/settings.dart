import 'package:isar/isar.dart';

import '../../common/config/configuration.dart';
import '../log/log.service.dart';

part 'settings.g.dart';

@collection
class Settings {
  Id id = Isar.autoIncrement;
  int logMaxLinesThreshold;
  int logMaxLinesRecovery;
  @enumerated
  LogLevel logLevel;
  int get dbLogLevel => logLevel.index;
  set dbLogLevel(int value) => logLevel = LogLevel.values[value];
  bool devEnableDeveloperOptions;
  String imgBackground;
  bool isDarkTheme;
  //Reader
  String fontFamily;
  int fontSize;

  Settings({
    this.id = 0,
    this.logMaxLinesThreshold = 3500,
    this.logMaxLinesRecovery = 500,
    this.logLevel = LogLevel.verbose,
    this.devEnableDeveloperOptions = true,
    this.imgBackground = Configuration.defaultBackground,
    this.isDarkTheme = false,
    this.fontFamily = Configuration.defaultFont,
    this.fontSize = Configuration.defaultFontSize,
  });
}
