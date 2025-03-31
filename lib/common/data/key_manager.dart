import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/log/log.service.dart';

class KeyManager {
  static final Map<String, GlobalKey<ScaffoldState>> _keys = {};

  static GlobalKey<ScaffoldState> getScaffoldKey(String key) {
    final log = GetIt.instance<LogService>();
    log.logInfo('Requesting GlobalKey for scaffold [$key].');
    if (_keys.containsKey(key)) {
      log.logInfo('Found key ${_keys[key].hashCode} for [$key]');
      return _keys[key]!;
    }

    var newKey = GlobalKey<ScaffoldState>(debugLabel: key);
    _keys[key] = newKey;
    log.logInfo(
        'Key not found for [$key]. Created a new one ${newKey.hashCode}');
    return newKey;
  }
}
