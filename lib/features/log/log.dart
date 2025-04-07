// We import necessary libraries for JSON conversion and logging, ensuring the Log class can serialize its data and interact with the logging system.
import 'dart:convert';

import 'log.service.dart';

class Log {
  // We declare a nullable timestamp to mark when the log entry was created.
  late DateTime? timestamp;
  // We set the log level to categorize the severity or type of the log.
  LogLevel level;
  // The message provides a human-readable description of the log event.
  String message;
  // The param field holds additional details, such as serialized objects or error messages, for deeper insight during debugging.
  String param;

  // The constructor allows for dynamic log creation with optional parameters.
  Log({
    this.timestamp,
    required this.level,
    required this.message,
    this.param = '',
    Object? object,
  }) {
    // We assign the current time if no timestamp is provided to ensure every log has a temporal context.
    timestamp ??= DateTime.now();

    // We check if an additional object was provided to add context to the log.
    if (object != null) {
      // We encode the object if the log level is data to facilitate structured logging.
      switch (level) {
        case LogLevel.data:
          param = jsonEncode(object, toEncodable: (o) => o.toString());
          break;
        // We extract the error message if the log level is error, supporting easier error tracking.
        case LogLevel.error:
          param = (object as Exception).toString();
          break;
        default:
          break;
      }
    }
  }

  // We convert the Log object into a map for serialization, enabling storage or network transmission.
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp!.millisecondsSinceEpoch,
      'level': level.index,
      'message': message,
      'param': param,
    };
  }

  // We use a factory constructor to rebuild a Log object from a map,
  // facilitating deserialization from stored or transmitted data.
  factory Log.fromMap(Map<String, dynamic> map) {
    return Log(
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      message: map['message'] ?? '',
      level: LogLevel.values[map['level'] as int],
      param: map['param'] ?? '',
    );
  }

  // We serialize the Log object into a JSON string to support interoperability with external systems.
  String toJson() => jsonEncode(toMap());

  // We create a factory constructor to build a Log object directly from a JSON string,
  // allowing for easy reconstruction from network responses or file storage.
  factory Log.fromJson(String source) => Log.fromMap(jsonDecode(source));

  // We override toString to provide a formatted representation of the log,
  // making it easier for developers to read and understand log outputs.
  @override
  String toString() {
    return '[${timestamp!.toIso8601String()}] [${level.name.toUpperCase()}] $message ${param.isNotEmpty ? param : ''}';
  }
}
