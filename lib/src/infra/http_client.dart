import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  static final _log = Logger('HTTP');

  var _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Use default client while logging requests
    _log.fine("[HTTP] --> $request");
    return _client.send(request).then((response) {
      _log.fine("[HTTP] <-- ${response.statusCode} $request");
      return response;
    }).catchError((e) {
      _log.warning("[HTTP] Error on $request: $e");
      return Future<http.StreamedResponse>.error(e);
    });
  }

  @override
  void close() {
    _client.close();
    super.close();
  }
}
