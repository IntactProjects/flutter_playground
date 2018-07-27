import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/data/property_service.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  test('Search properties with basic http client', () async {
    var result = await PropertyService(http.Client()).search("leeds");

    expect(result.type, ResultType.SUCCESSFUL);
    expect(result.properties, isNotEmpty);
    expect(result.locations.length, 1);
  });

  test('Search properties with custom http client', () async {
    var result = await PropertyService(HttpClient()).search("leeds");

    expect(result.type, ResultType.SUCCESSFUL);
    expect(result.properties, isNotEmpty);
    expect(result.locations.length, 1);
  });
}
