import 'package:flutter_playground/models.dart';

class SearchResult {
  final query;
  final PropertyResult propertyResult;
  final Iterable<Location> locations;
  final SearchError error;

  List<Property> get properties => propertyResult?.properties?.toList() ?? [];

  const SearchResult({
    this.query,
    this.propertyResult,
    this.locations = const [],
    this.error,
  });

  const SearchResult.failed(SearchError error) : this(error: error);

  ResultType get type {
    if (propertyResult != null && !propertyResult.isEmpty) {
      return ResultType.SUCCESSFUL;
    } else if (propertyResult != null &&
        propertyResult.isEmpty &&
        locations.length > 1) {
      return ResultType.AMBIGUOUS;
    } else if (propertyResult != null &&
        propertyResult.isEmpty &&
        error == null) {
      return ResultType.NO_RESULT;
    } else {
      return ResultType.FAILED;
    }
  }
}

enum SearchError {
  SEARCH_TIMEOUT,
  UNKNOWN_LOCATION,
  COORDINATE_ERROR,
  INVALID_REQUEST,
  SERVER_ERROR,

  LOCATION_DISABLED,
  LOCATION_PERMISSION_REFUSED,
  LOCATION_TIMEOUT,
}

enum ResultType {
  SUCCESSFUL,
  NO_RESULT,
  AMBIGUOUS,
  FAILED,
}
