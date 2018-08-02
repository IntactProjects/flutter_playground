import 'package:flutter_playground/models.dart';
import 'package:meta/meta.dart';

class RecentSearch {
  final String label;
  final query;
  final int resultCount;
  final DateTime searchDate;

  RecentSearch({
    label,
    @required this.query,
    @required this.resultCount,
    DateTime searchDate,
  })  : assert(query != null),
        assert(resultCount != null),
        assert(label != null || query is String,
            'label is required for non-String query'),
        label = label ?? query,
        searchDate = searchDate ?? DateTime.now();

  RecentSearch.fromJson(Map<String, dynamic> json)
      : label = json['label'] ?? json['query'],
        query = _deserializeQuery(json['query'], json['queryType']),
        resultCount = json['resultCount'],
        searchDate = DateTime.parse(json['searchDate']);

  Map<String, dynamic> toJson() => {
        'label': label,
        'query': query,
        'queryType': _queryType(query),
        'resultCount': resultCount,
        'searchDate': searchDate.toIso8601String(),
      };
}

const _QUERY_TYPE_STRING = 'STRING';
const _QUERY_TYPE_GEOLOCATION = 'GEOLOC';
const _QUERY_TYPE_LOCATION = 'LOCATION';

String _queryType(query) {
  if (query is String) {
    return _QUERY_TYPE_STRING;
  } else if (query is Geolocation) {
    return _QUERY_TYPE_GEOLOCATION;
  } else if (query is Location) {
    return _QUERY_TYPE_LOCATION;
  }
  throw UnsupportedError('Query type is not supported ${query.runtimeType}');
}

_deserializeQuery(queryJson, String queryType) {
  switch (queryType) {
    case _QUERY_TYPE_GEOLOCATION:
      return Geolocation.fromJson(queryJson);
    case _QUERY_TYPE_LOCATION:
      return Location.fromJson(queryJson);
    case _QUERY_TYPE_STRING:
    default:
      return queryJson;
  }
}
