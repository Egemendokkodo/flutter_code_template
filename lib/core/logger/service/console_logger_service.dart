import 'package:flutter/foundation.dart';
import 'logger_service.dart';

class ConsoleLoggerService implements LoggerService {
  @override
  void log(
    String message, {
    LogLevel level = LogLevel.debug,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && level == LogLevel.debug) return;

    final prefix = switch (level) {
      LogLevel.debug => '🐛 DEBUG',
      LogLevel.info => 'ℹ️ INFO',
      LogLevel.warning => '⚠️ WARN',
      LogLevel.error => '❌ ERROR',
    };

    debugPrint('$prefix | $message');

    if (error != null) {
      debugPrint('↳ error: $error');
    }

    if (stackTrace != null) {
      debugPrint('↳ stackTrace: $stackTrace');
    }
  }
}
