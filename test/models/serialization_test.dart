import 'dart:convert';

import 'package:flutter_playground/models.dart';
import 'package:test/test.dart';

void main() {
  group('Serialize RecentSearch', () {
    test('by name', () {
      final query = "QUERY";
      var rs = RecentSearch(
        resultCount: 2,
        query: query,
      );

      var jsonEncoded = json.encode(rs);
      var actual = RecentSearch.fromJson(json.decode(jsonEncoded));

      expect(actual.label, rs.label);
      expect(actual.query, rs.query);
      expect(actual.resultCount, rs.resultCount);
      expect(actual.searchDate, rs.searchDate);
    });

    test('by geolocation', () {
      final query = Geolocation(latitude: 12.5, longitude: -32.532);
      var rs = RecentSearch(
        label: 'Somewhere',
        query: query,
        resultCount: 22,
      );

      var jsonEncoded = json.encode(rs);
      var actual = RecentSearch.fromJson(json.decode(jsonEncoded));

      expect(actual.label, rs.label);
      expect(actual.query, rs.query);
      expect(actual.resultCount, rs.resultCount);
      expect(actual.searchDate, rs.searchDate);
    });

    test('by location', () {
      final query = Location(key: 'great_london', label: 'Great London');
      var rs = RecentSearch(
        label: query.label,
        query: query,
        resultCount: 42,
      );

      var jsonEncoded = json.encode(rs);
      var actual = RecentSearch.fromJson(json.decode(jsonEncoded));

      expect(actual.label, rs.label);
      expect(actual.query, rs.query);
      expect(actual.resultCount, rs.resultCount);
      expect(actual.searchDate, rs.searchDate);
    });
  });
}
