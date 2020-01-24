import 'dart:developer' as developer;

class Log {
  static const String appName = 'MORPHEUS';
  final Type _className;

  Log(this._className);

  void debug(String message) {
    _log(_className, message, LogLevel.Debug);
  }

  void trace(String message) {
    _log(_className, message, LogLevel.Trace);
  }

  void info(String message) {
    _log(_className, message, LogLevel.Info);
  }

  static void _log(Type className, String message, int loglevel) {
    developer.log(
        '${DateTime.now()} [$className] - $message',
        level: loglevel, name: appName
    );
  }
}

class LogLevel {
  static const int Trace = 500;
  static const int Debug = 1000;
  static const int Info = 1500;
}
