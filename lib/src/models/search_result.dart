import 'package:flutter_playground/models.dart';

class SearchResult {
  final Iterable<Property> properties;
  final Iterable<Location> locations;
  final SearchError error;

  const SearchResult({
    this.properties = const [],
    this.locations = const [],
    this.error,
  });

  bool get successful => error == null && properties.isNotEmpty;
  bool get ambiguous =>
      error == null && properties.isEmpty && locations.isNotEmpty;
  bool get failed => error != null;
}

enum SearchError {
  TIMEOUT,
  UNKNOWN_LOCATION,
  COORDINATE_ERROR,
  INVALID_REQUEST,
  SERVER_ERROR,
}
