import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:http/testing.dart';
import 'package:quiver/testing/async.dart';
import 'package:test/test.dart';

import 'responses.dart' as responses;

void main() {
  test('Search properties by name', () async {
    var http = MockClient((_) => Future.value(responses.searchByName));
    var result = await PropertyService(http).search("leeds");

    expect(result.type, ResultType.SUCCESSFUL);
    expect(result.properties.length, 20);
    expect(result.locations.length, 1);

    var prop = result.properties.first;
    expect(prop.price, 254950);
  });

  test('Search properties by location', () async {
    var http = MockClient((_) => Future.value(responses.searchByLocation));
    var result = await PropertyService(http)
        .searchAround(Geolocation(latitude: 51.684183, longitude: -3.431481));

    expect(result.type, ResultType.SUCCESSFUL);
    expect(result.properties.length, 20);
    expect(result.locations.length, 1);
  });

  test('Search properties ambiguous', () async {
    var http = MockClient((_) => Future.value(responses.searchAmbiguous));
    var result = await PropertyService(http).search("something");

    expect(result.type, ResultType.AMBIGUOUS);
    expect(result.properties.length, 0);
    expect(result.locations.length, 2);
  });

  test(
    'Search should timeout after 5 seconds',
    () => FakeAsync().run((fakeAsync) {
          var http = MockClient(
            (_) => Future.delayed(
                Duration(seconds: 6), () => responses.searchByLocation),
          );

          PropertyService(http).search("something").then((result) {
            expect(result.type, ResultType.FAILED);
            expect(result.error, SearchError.SEARCH_TIMEOUT);
            expect(result.properties.length, 0);
            expect(result.locations.length, 0);
          });

          fakeAsync.elapse(Duration(seconds: 6));
        }),
    timeout: Timeout(Duration(seconds: 10)),
  );
}
