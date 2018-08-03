import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/widgets.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/screens/home/form_body.dart';
import 'package:flutter_playground/src/screens/home/location_selection_list.dart';
import 'package:flutter_playground/src/screens/home/recent_search_list.dart';

final _log = Logger('HomePage');

enum DisplayMode {
  RECENT,
  LOCATIONS,
  ERROR,
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _searching;
  DisplayMode _displayMode;
  SearchResult _result;
  TextEditingController _textController;

  Widget _recentList;

  @override
  void initState() {
    super.initState();
    _searching = false;
    _displayMode = DisplayMode.RECENT;
    _textController = TextEditingController()
      ..addListener(() {
        if (_textController.text.isEmpty) {
          setState(() => _displayMode = DisplayMode.RECENT);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    var appBarActions = <Widget>[
      IconButton(
        icon: Icon(Icons.star),
        onPressed: () => _goToFavorites(context),
        tooltip: "Favorites",
      )
    ];

    if (_searching && defaultTargetPlatform == TargetPlatform.android) {
      var appTheme = Theme.of(context);
      appBarActions.insert(0, AppBarProgressIndicator(appTheme: appTheme));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PropertyCross'),
        actions: appBarActions,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Use the form below to search for houses to buy. " +
                  "You can search by place-name, postcode, or click 'My location', " +
                  "to search in your current location!"),
              SizedBox(height: 16.0),
              FormBody(
                searching: _searching,
                onSubmit: _doSearch,
                textController: _textController,
              ),
              SizedBox(height: 16.0),
              Builder(builder: (context) {
                switch (_displayMode) {
                  case DisplayMode.LOCATIONS:
                    return LocationSelectionList(
                      candidates: _result.locations,
                    );
                  case DisplayMode.ERROR:
                    return Text(_getErrorMessage());
                  case DisplayMode.RECENT:
                  default:
                    return _displayRecentList(context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayRecentList(BuildContext context) {
    // Cache the RecentSearchList widget to avoid flashing when the state is changed
    // The flashing is caused by the FutureBuilder rebuilding inside RecentSearchList
    // TODO Find a better way to re-use the widget
    if (_recentList == null) {
      _recentList = RecentSearchList(
        onTap: _searching ? null : (query) => _doSearch(context, query),
      );
    }
    return _recentList;
  }

  void _goToFavorites(BuildContext context) {
    AppNavigator.goToFavorites(context);
  }

  void _doSearch(BuildContext context, String query) {
    var provider = Provider.of(context);
    var propertyService = provider.propertyService;

    setState(() => _searching = true);
    if (query == SEARCH_MY_LOCATION) {
      provider.geolocationService
          .getLocation()
          .then((geoloc) => propertyService.search(geoloc))
          .catchError(_handleGeolocError)
          .then((result) => _onSearchResult(context, result));
    } else {
      propertyService
          .search(query)
          .then((result) => _onSearchResult(context, result));
    }
  }

  void _onSearchResult(BuildContext context, SearchResult result) {
    DisplayMode resultDisplayMode = _displayMode;
    switch (result.type) {
      case ResultType.SUCCESSFUL:
        Provider.of(context).recentService.saveSearch(result.query, result);
        resultDisplayMode = DisplayMode.RECENT;
        AppNavigator.goToSearchResults(
          context,
          result,
        );
        break;
      case ResultType.AMBIGUOUS:
        resultDisplayMode = DisplayMode.LOCATIONS;
        break;
      default:
        resultDisplayMode = DisplayMode.ERROR;
    }

    _log.finer(
        'Result type: ${result.type} => Display mode $resultDisplayMode');
    setState(() {
      _searching = false;
      _displayMode = resultDisplayMode;
      _result = result;
    });
  }

  SearchResult _handleGeolocError(e) {
    SearchError searchError;
    if (e is TimeoutException) {
      searchError = SearchError.LOCATION_TIMEOUT;
    } else if (e is PlatformException && e.code == 'PERMISSION_DENIED') {
      searchError = SearchError.LOCATION_PERMISSION_REFUSED;
    } else {
      searchError = SearchError.LOCATION_DISABLED;
    }
    return SearchResult.failed(searchError);
  }

  String _getErrorMessage() {
    if (_result == null) return null;

    if (_result.type == ResultType.NO_RESULT) {
      return "There were no properties found for the given location.";
    }

    switch (_result.error) {
      case SearchError.SEARCH_TIMEOUT:
        return "An error occurred while searching. Please check your network connection and try again.";
      case SearchError.UNKNOWN_LOCATION:
      case SearchError.COORDINATE_ERROR:
        return "The location given was not recognised.";
      case SearchError.LOCATION_DISABLED:
        return "The use of location is currently disabled.";
      case SearchError.LOCATION_PERMISSION_REFUSED:
        return "The use of location has been refused.";
      case SearchError.LOCATION_TIMEOUT:
        return "Unable to detect current location. Please ensure location is turned on in your phone settings and try again.";
      default:
        return "There was a problem with your search";
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
