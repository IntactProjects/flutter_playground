import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';

class MockPropertyService implements PropertyService {
  final _searchResult = SearchResult(
      query: "london",
      propertyResult: PropertyResult(properties: _createProperties()));

  static List<Property> _createProperties() {
    var properties = <Property>[];

    for (int i = 0; i < 100; ++i) {
      properties.add(
        Property(
            address: "$i rue Royale, Lyon",
            locality: "France",
            price: 333333.0,
            image: ImageInfo(
              uri: Uri.https("i.ytimg.com", "vi/fq4N0hgOWzU/maxresdefault.jpg"),
              height: 300.0,
              width: 400.0,
            )),
      );
    }

    return properties;
  }

  @override
  Future<SearchResult> search(query, {int page = 1}) => Future.delayed(
        Duration(seconds: 1, milliseconds: 500),
        () => _searchResult,
      );
}
