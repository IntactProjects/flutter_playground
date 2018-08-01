import 'dart:async';

import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/data/property_service.dart';

class MockPropertyService implements PropertyService {
  final _searchResult = SearchResult(
      query: "london",
      propertyResult: PropertyResult(properties: _createProperties()));

  static List<Property> _createProperties() {
    var properties = <Property>[];

    for (int i = 0; i < 100; ++i) {
      properties.add(Property(
          address: "$i rue Royale, Lyon",
          locality: "France",
          price: 333333.0,
          image: Uri.https("i.ytimg.com", "vi/fq4N0hgOWzU/maxresdefault.jpg")));
    }

    return properties;
  }

  @override
  Future<SearchResult> search(query, {int page = 1}) => _mockSearch();

  @override
  Future<SearchResult> searchByName(String query, {int page: 1}) =>
      _mockSearch();

  @override
  Future<SearchResult> searchAround(Geolocation location, {int page = 1}) =>
      _mockSearch();

  Future<SearchResult> _mockSearch() {
    return Future.delayed(
      Duration(seconds: 1, milliseconds: 500),
      () => _searchResult,
    );
  }
}
