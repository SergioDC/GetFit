import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../common/config/configuration.dart';
import 'log.dart';

enum LogLevel { data, info, warning, error, none }

class LogService with ChangeNotifier {
  File? _logFile;
  final List<Log> logBuffer = [];
  bool isReady = false;
  int logCount = 0;
  String logPath = '';

  // Mutex to synchronize write and prune operations
  final _mutex = Mutex();

  LogService._internal() {
    _initializeLogFile();
  }


  static final LogService _instance = LogService._internal();
  static Color getColor(LogLevel level) {
    switch(level)
    {
      case LogLevel.data:
        return Colors.grey;
      case LogLevel.info:
        return Colors.white;
      case LogLevel.warning:
        return Colors.yellow;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.none:
        return Colors.purple;
    }
  }

  factory LogService() {
    return _instance;
  }

  Future<void> _initializeLogFile() async {
    final directory = Directory(p.join(
        (await getApplicationDocumentsDirectory()).path,
        Configuration.logFolderName));
    logPath = p.join(directory.path, Configuration.logFileName);
    _logFile = File(logPath);
    if (!await directory.exists()) {
      await directory.create();
    }
    if (!await _logFile!.exists()) {
      await _logFile!.create();
    } else {
      var logList = await _readLogs();
      if (logList.isNotEmpty) {
        logBuffer.addAll(logList);
        logInfo('Read ${logList.length} previous logs.');
      }
    }
    isReady = true;

    logInfo('Logging service is ready.');
    logInfo('logInfo test.');
    logData('logData test.', {'key': 1, 'field': 'sample', 'time': 'now()'});
    logWarning('logWarning test.');
    logError('logError test.', Exception('Test exception'));

    notifyListeners();
  }

  void logData(String message, Object? data) {
    _writeLog(level: LogLevel.data, message: message, object: data ?? '');
  }

  void logInfo(String message) {
    _writeLog(level: LogLevel.info, message: message);
  }

  void logWarning(String message) {
    _writeLog(level: LogLevel.warning, message: message);
  }

  void logError(String message, Exception exception) {
    _writeLog(level: LogLevel.error, message: message, object: exception);
  }

  Future<void> _writeLog({
    LogLevel level = LogLevel.info,
    String message = 'Undefined Log',
    Object? object,
  }) async {
    var currentLogLevel = LogLevel.data.index;
    if (currentLogLevel > level.index) {
      return;
    }

    await _mutex.acquire();

    // Wait for log file to be ready
    while (_logFile == null || !await _logFile!.exists()) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    try {
      var logEntry = Log(
        level: level,
        message: message,
        object: object,
      );

      logBuffer.add(logEntry);
      logCount++;

      if (Configuration.logAlsoWriteToConsole) {
        debugPrint(logEntry.toString());
      }

      // Append the new log entry to the file
      try {
        final sink = _logFile!.openWrite(mode: FileMode.append);
        var newLogEntry = logEntry.toJson();
        sink.writeln(newLogEntry);
        await sink.close();
      } catch (e) {
        debugPrint('Error writing to log file: $e');
      }

      // Check if pruning is needed
      var maxLinesThreshold = Configuration.logMaxThresholdLines;
      if (logCount > maxLinesThreshold) {
        await _pruneLogs();
      }
    } finally {
      _mutex.release(); // Release the mutex
    }

    notifyListeners();
  }

  Future<List<Log>> _readLogs() async {
    if (await _logFile!.exists()) {
      var logLines = await _logFile!.readAsLines();
      List<Log> logList = [];
      for (var l in logLines) {
        try {
          var log = Log.fromJson(l);
          logList.add(log);
        } catch (e) {
          var log = Log(
              level: LogLevel.warning,
              message: 'Error loading log from file: [$e]->[$l]');
          logList.add(log);
        }
      }
      logCount = logList.length;
      return logList;
    }
    logCount = 0;
    return [];
  }

  Future<void> clearLogs() async {
    if (await _logFile!.exists()) {
      await _logFile!.writeAsString('');
    }
    logBuffer.clear();
    logCount = 0;
  }

  Future<void> _pruneLogs() async {
    try {
      var linesRecoveryAmount = Configuration.logMaxRecoveryLines;

      // Read all lines
      var logLines = await _logFile!.readAsLines();

      // Ensure there are enough lines to prune
      if (logLines.length > linesRecoveryAmount) {
        // Remove the first `pruneCount` lines
        var prunedLines = logLines.sublist(linesRecoveryAmount);

        // Rewrite the file with pruned lines
        await _logFile!
            .writeAsString('${prunedLines.join('\n')}\n', mode: FileMode.write);
        logCount -= linesRecoveryAmount;
        logLines = prunedLines;
        logInfo(
            'Pruned $linesRecoveryAmount log lines. New log count: $logCount');
      }
    } catch (e) {
      debugPrint('Error pruning log file: $e');
    }
  }
}
