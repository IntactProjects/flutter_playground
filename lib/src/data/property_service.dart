import 'dart:async';
import 'dart:convert';

import 'package:flutter_playground/models.dart';
import 'package:http/http.dart' show Client;

class PropertyService {
  static const _AUTHORITY = 'api.nestoria.co.uk';
  static const _PATH = '/api';
  static const _TIMEOUT = const Duration(seconds: 5);

  static Map<String, String> get _defaultParams => <String, String>{
        'action': 'search_listings',
        'country': 'uk',
        'encoding': 'json',
        'listing_type': 'buy',
      };

  final Client _client;

  const PropertyService(client)
      : assert(client != null),
        _client = client;

  Future<SearchResult> search(String query, {int page = 1}) {
    // "http://api.nestoria.co.uk/api?country=uk&pretty=1&action=search_listings&encoding=json&listing_type=buy&page=1&place_name=leeds";
    var uri = _buildUri(<String, String>{
      'place_name': query,
      'page': '$page',
    });
    return _get(uri);
  }

  Future<SearchResult> searchAround(Geolocation location, {int page = 1}) {
    // "https://api.nestoria.co.uk/api?country=uk&pretty=1&action=search_listings&encoding=json&listing_type=buy&page=1&centre_point=51.684183,-3.431481";
    var uri = _buildUri(<String, String>{
      'centre_point': '${location.latitude},${location.longitude}',
      'page': '$page',
    });
    return _get(uri);
  }

  Uri _buildUri(Map<String, String> params) {
    return Uri.https(_AUTHORITY, _PATH, _defaultParams..addAll(params));
  }

  Future<SearchResult> _get(Uri uri) {
    return _client
        .get(uri)
        .then((response) => response.body)
        .then(json.decode)
        .then(_processJson)
        .timeout(
          _TIMEOUT,
          onTimeout: () => SearchResult(error: SearchError.TIMEOUT),
        );
  }
}

SearchResult _processJson(rawValue) {
  var response = rawValue['response'];
  int responseCode = int.parse(response['application_response_code']);
  return SearchResult(
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
    image: Uri.parse(jsonValue['img_url']),
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
  if (responseCode == 201) {
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
