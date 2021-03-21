import 'package:args/command_runner.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

final _logger = Logger('http_command');

class HttpCommand extends Command<void> {
  HttpCommand() {
    argParser.addOption('method',
        abbr: 'm',
        allowed: [
          'get',
          'post',
          'put',
        ],
        defaultsTo: 'get');
  }
  @override
  final String name = 'http';

  @override
  final String description = 'GET request to the given URL.';

  @override
  Future<void> run() async {
    if (argResults!.rest.isEmpty) {
      printUsage();
      return;
    }
    final url = argResults!.rest.first;
    final c = Client();
    final req = Request(argResults!['method'] as String, Uri.parse(url));
    _logger.finest('Sending request...');
    final streamResponse = await c.send(req);
    _logger.finest('Sent request. ${streamResponse.statusCode}');
    final response = await Response.fromStream(streamResponse);
    _logger.fine('Received response ${response.statusCode}');
    print(response.body);
    c.close();
  }
}
