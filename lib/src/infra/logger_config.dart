import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

class LoggerConfig {
  attach({level = Level.FINE}) {
    Logger.root
      ..level = level
      ..onRecord.listen(_onLog);
  }

  @protected
  void _onLog(LogRecord rec) {
    var time = rec.time;
    var message = '${rec.level.name}: $time: ${rec.message}';
    if (rec.error != null) {
      message += ' ${rec.error}';
    }
    print(message);
  }
}
