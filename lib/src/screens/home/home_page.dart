import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/src/screens/app_navigator.dart';
import 'package:flutter_playground/widgets.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/screens/home/form_body.dart';
import 'package:flutter_playground/src/screens/home/location_selection_list.dart';
import 'package:flutter_playground/src/screens/home/recent_search_list.dart';

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

  @override
  void initState() {
    super.initState();
    this._searching = false;
    this._displayMode = DisplayMode.RECENT;
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
              FormBody(searching: _searching, onSubmit: _search),
              SizedBox(height: 16.0),
              Builder(builder: (context) {
                switch (_displayMode) {
                  case DisplayMode.RECENT:
                    return RecentSearchList();
                  case DisplayMode.LOCATIONS:
                    return LocationSelectionList(
                      candidates: _result.locations,
                    );
                  case DisplayMode.ERROR:
                    return Text(_getErrorMessage());
                  default:
                    return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _goToFavorites(BuildContext context) {
    AppNavigator.goToFavorites(context);
  }

  void _search(BuildContext context, String query) {
    var propertyService = Provider.of(context).propertyService;
    if (query == SEARCH_MY_LOCATION) {
      // TODO Search around
      Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("TODO Search $query")),
          );
    } else {
      setState(() => _searching = true);
      propertyService
          .search(query)
          .then((result) => _onSearchResult(context, result));
    }
  }

  void _onSearchResult(BuildContext context, SearchResult result) {
    DisplayMode displayMode;
    switch (result.type) {
      case ResultType.SUCCESSFUL:
        setState(() {
          _searching = false;
          _displayMode = DisplayMode.RECENT;
        });
        AppNavigator.goToSearchResults(context, result.properties.toList());
        break;
      case ResultType.AMBIGUOUS:
        displayMode = DisplayMode.LOCATIONS;
        break;
      default:
        displayMode = DisplayMode.ERROR;
    }

    setState(() {
      _searching = false;
      _displayMode = displayMode;
      _result = result;
    });
  }

  String _getErrorMessage() {
    if (_result == null) return null;

    if (_result.type == ResultType.NO_RESULT) {
      return "There were no properties found for the given location.";
    }

    // TODO Handle location (GPS) error
    switch (_result.error) {
      case SearchError.TIMEOUT:
        return "An error occurred while searching. Please check your network connection and try again.";
      case SearchError.UNKNOWN_LOCATION:
      case SearchError.COORDINATE_ERROR:
        return "The location given was not recognised.";
      default:
        return "There was a problem with your search";
    }
  }
}
