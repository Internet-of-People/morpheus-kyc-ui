import 'dart:developer' as developer;

class Log {
  static const String APP_NAME = 'MORPHEUS';

  static void debug(String message) {
    _log(message, LogLevel.DEBUG);
  }

  static void trace(String message) {
    _log(message, LogLevel.TRACE);
  }

  static void info(String message) {
    _log(message, LogLevel.INFO);
  }

  static void _log(String message, int loglevel) {
    developer.log('${DateTime.now()} - $message',level: loglevel, name: APP_NAME);
  }
}

class LogLevel {
  static const int TRACE = 500;
  static const int DEBUG = 1000;
  static const int INFO = 1500;
}
