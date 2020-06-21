import 'package:logging/logging.dart';

final _logger = Logger('env');

abstract class Env {
  Env() {
    assert((() {
      assertEnabled = true;
      return true;
    })());
    if (!assertEnabled && debug) {
      _logger.warning(
          'Assertions are disabled, but you still use dev environment!');
    }
  }

  bool assertEnabled = false;

  bool get debug;

  /// help text displayed in the command line help.
  String get help;
}

class ProdEnv extends Env {
  @override
  bool get debug => throw UnimplementedError();

  @override
  String get help => 'Production environment';
}

class DevEnv extends Env {
  @override
  bool get debug => throw UnimplementedError();

  @override
  String get help => 'Development environment';
}
