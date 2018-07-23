import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  static final _log = Logger('HTTP');

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Use default client while logging requests
    _log.config("$request");
    var client = http.Client();
    return client.send(request).whenComplete(() => client.close());
  }
}
