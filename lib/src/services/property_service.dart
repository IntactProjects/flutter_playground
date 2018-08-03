import 'dart:async';
import 'dart:convert';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:http/http.dart' show Client;

final _log = Logger('PropertyService');

class PropertyService {
  static const _AUTHORITY = 'api.nestoria.co.uk';
  static const _PATH = '/api';

  static Map<String, String> get _defaultParams => <String, String>{
        'action': 'search_listings',
        'country': 'uk',
        'encoding': 'json',
        'listing_type': 'buy',
      };

  final Client _client;
  final Duration _timeout;

  const PropertyService(client, {timeout = const Duration(seconds: 5)})
      : assert(client != null),
        assert(timeout != null),
        _client = client,
        _timeout = timeout;

  Future<SearchResult> search(query, {int page = 1}) {
    if (query is String) {
      return _searchByName(query, page);
    } else if (query is Geolocation) {
      return _searchAround(query, page);
    } else if (query is Location) {
      return _searchByName(query.key, page);
    } else {
      throw new UnsupportedError(
          "Query of type ${query.runtimeType} are not supported");
    }
  }

  Future<SearchResult> _searchByName(String query, int page) {
    // "http://api.nestoria.co.uk/api?country=uk&pretty=1&action=search_listings&encoding=json&listing_type=buy&page=1&place_name=leeds";
    var uri = _buildUri(<String, String>{
      'place_name': query,
      'page': '$page',
    });
    return _get(query, uri);
  }

  Future<SearchResult> _searchAround(Geolocation location, int page) {
    // "https://api.nestoria.co.uk/api?country=uk&pretty=1&action=search_listings&encoding=json&listing_type=buy&page=1&centre_point=51.684183,-3.431481";
    var uri = _buildUri(<String, String>{
      'centre_point': '${location.latitude},${location.longitude}',
      'page': '$page',
    });
    return _get(location, uri);
  }

  Uri _buildUri(Map<String, String> params) {
    return Uri.https(_AUTHORITY, _PATH, _defaultParams..addAll(params));
  }

  Future<SearchResult> _get(query, Uri uri) {
    return _client
        .get(uri)
        .then((response) => response.body)
        .then(json.decode)
        .then((rawValue) => _processJson(query, rawValue))
        .timeout(_timeout)
        .catchError((e) {
      if (e is TimeoutException) {
        return SearchResult.failed(SearchError.SEARCH_TIMEOUT);
      } else {
        _log.warning("Search error", e);
        return SearchResult.failed(SearchError.SERVER_ERROR);
      }
    });
  }
}

SearchResult _processJson(query, rawValue) {
  var response = rawValue['response'];
  int responseCode = int.parse(response['application_response_code']);
  return SearchResult(
    query: query,
    propertyResult: _jsonToPropertyResult(response),
    locations: response['locations'].map<Location>(_jsonToLocation),
    error: _searchError(responseCode),
  );
}

PropertyResult _jsonToPropertyResult(jsonValue) {
  return PropertyResult(
    properties: jsonValue['listings'].map<Property>(_jsonToProperty),
    page: jsonValue['page'],
    totalResults: jsonValue['total_results'],
  );
}

Property _jsonToProperty(jsonValue) {
  return Property(
    address: jsonValue['title'],
    summary: jsonValue['summary'],
    price: jsonValue['price'].toDouble(),
    image: ImageInfo(
      uri: Uri.parse(jsonValue['img_url']),
      width: double.tryParse(jsonValue['img_width'].toString()) ?? 0.0,
      height: double.tryParse(jsonValue['img_height'].toString()) ?? 0.0,
    ),
    thumb: ImageInfo(
      uri: Uri.parse(jsonValue['thumb_url']),
      width: double.tryParse(jsonValue['thumb_width'].toString()) ?? 0.0,
      height: double.tryParse(jsonValue['thumb_height'].toString()) ?? 0.0,
    ),
    bathrooms: int.tryParse(jsonValue['bathroom_number'].toString()) ?? 0,
    bedrooms: int.tryParse(jsonValue['bedroom_number'].toString()) ?? 0,
  );
}

Location _jsonToLocation(jsonValue) {
  return Location(
    key: jsonValue['place_name'],
    label: jsonValue['title'],
  );
}

SearchError _searchError(int responseCode) {
  // See https://www.nestoria.co.uk/help/api-return-codes
  if (responseCode == 200 || responseCode == 201) {
    return SearchError.UNKNOWN_LOCATION;
  } else if (responseCode == 210) {
    return SearchError.COORDINATE_ERROR;
  } else if (responseCode == 500) {
    return SearchError.SERVER_ERROR;
  } else if (responseCode >= 900 && responseCode <= 999) {
    return SearchError.INVALID_REQUEST;
  }
  return null;
}
