import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

abstract class LoggerService {
  void log(
    String message, {
    LogLevel level = LogLevel.debug,
    Object? error,
    StackTrace? stackTrace,
  });
}
