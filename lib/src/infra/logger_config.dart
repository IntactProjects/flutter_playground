import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

class LoggerConfig {
  attach({level = Level.CONFIG}) {
    Logger.root
      ..level = level
      ..onRecord.listen(_onLog);
  }

  @protected
  void _onLog(LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  }
}
