import 'dart:developer' as developer;

class Log {
  static const String appName = 'MORPHEUS';

  static void debug(String message) {
    _log(message, LogLevel.Debug);
  }

  static void trace(String message) {
    _log(message, LogLevel.Trace);
  }

  static void info(String message) {
    _log(message, LogLevel.Info);
  }

  static void _log(String message, int loglevel) {
    developer.log('${DateTime.now()} - $message',
        level: loglevel, name: appName);
  }
}

class LogLevel {
  static const int Trace = 500;
  static const int Debug = 1000;
  static const int Info = 1500;
}
