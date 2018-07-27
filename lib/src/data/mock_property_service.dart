import 'dart:async';

import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/data/property_service.dart';

class MockPropertyService implements PropertyService {
  final _searchResult = SearchResult(
    properties: <Property>[
      // TODO Add mocked properties here
    ],
  );

  @override
  Future<SearchResult> search(String query) => _mockSearch();

  @override
  Future<SearchResult> searchAround(Geolocation location) => _mockSearch();

  Future<SearchResult> _mockSearch() {
    return Future.delayed(
      Duration(seconds: 1, milliseconds: 500),
      () => _searchResult,
    );
  }
}
