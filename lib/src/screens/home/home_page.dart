import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/src/screens/home/form_body.dart';
import 'package:flutter_playground/src/screens/home/location_selection_list.dart';
import 'package:flutter_playground/src/screens/home/recent_search_list.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

enum DisplayMode {
  RECENT,
  LOCATIONS,
  ERROR,
}

class HomePageState extends State<HomePage> {
  bool _searching;
  DisplayMode _displayMode;

  @override
  void initState() {
    super.initState();
    this._searching = false;
    this._displayMode = DisplayMode.RECENT;
  }

  @override
  Widget build(BuildContext context) {
    var propertyService = Provider.of(context).propertyService;
    if (propertyService == null) throw StateError("propertyService is null");

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
                    return LocationSelectionList();
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
    Navigator.of(context).pushNamed(NamedRoutes.FAVORITES);
  }

  void _search(BuildContext context, String query) {
    Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("TODO Search $query")),
        );
    setState(() => _searching = true);
    Future
        .delayed(Duration(seconds: 2))
        .then((_) => setState(() => _searching = false));
  }

  String _getErrorMessage() {
    // TODO Build error message according to the SearchResult
    return "There was a problem with your search";
  }
}

class AppBarProgressIndicator extends StatelessWidget {
  const AppBarProgressIndicator({
    Key key,
    @required this.appTheme,
  }) : super(key: key);

  final ThemeData appTheme;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        height: 24.0,
        width: 24.0,
        child: Theme(
          data: appTheme.copyWith(
            accentColor: appTheme.primaryIconTheme.color,
          ),
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
      onPressed: null,
    );
  }
}
