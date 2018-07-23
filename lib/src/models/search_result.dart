import 'package:flutter_playground/models.dart';

class SearchResult {
  final List<Property> properties;
  final List<Location> locations;
  final SearchError error;

  const SearchResult({this.properties, this.locations, this.error});

  bool get successful => error == null && properties.isNotEmpty;
  bool get ambiguous =>
      error == null && properties.isEmpty && locations.isNotEmpty;
  bool get failed => error != null;
}

enum SearchError {
  NO_RESULTS,
  LOCATION_NOT_MATCHED,
  NETWORK_ISSUE,
  LOCATION_DISABLED,
  LOCATION_NOT_FOUND
}
