import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  static final _log = Logger('HTTP');

  var _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Use default client while logging requests
    _log.config("[HTTP] $request");
    return _client.send(request).catchError((e) {
      _log.severe("[HTTP] Error on $request: $e");
      return e;
    });
  }

  @override
  void close() {
    _client.close();
    super.close();
  }
}
