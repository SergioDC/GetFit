import 'dart:convert';

import 'log.service.dart';

class Log {
  late DateTime? timestamp;
  LogLevel level;
  String message;
  String param;

  Log({
    this.timestamp,
    required this.level,
    required this.message,
    this.param = '',
    Object? object,
  }) {
    timestamp ??= DateTime.now();
    if (object != null) {
      switch (level) {
        case LogLevel.data:
          param = jsonEncode(object);
          break;
        case LogLevel.error:
          param = (object as Exception).toString();
          break;
        default:
          break;
      }
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp!.millisecondsSinceEpoch,
      'level': level.index,
      'message': message,
      'param': param,
    };
  }

  factory Log.fromMap(Map<String, dynamic> map) {
    return Log(
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      message: map['message'] ?? '',
      level: LogLevel.values[map['level'] as int],
      param: map['param'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Log.fromJson(String source) => Log.fromMap(jsonDecode(source));

  @override
  String toString() {
    return '[${timestamp!.toIso8601String()}] [${level.name.toUpperCase()}] $message ${param.isNotEmpty ? param : ''}';
  }
}
