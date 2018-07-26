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

enum ContentState {
  RECENT,
  LOCATIONS,
  ERROR,
}

class HomePageState extends State<HomePage> {
  ContentState contentState;

  @override
  void initState() {
    super.initState();
    this.contentState = ContentState.RECENT;
  }

  @override
  Widget build(BuildContext context) {
    var propertyService = Provider.of(context).propertyService;
    if (propertyService == null) throw StateError("propertyService is null");

    return Scaffold(
      appBar: AppBar(
        title: Text('PropertyCross'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () => _goToFavorites(context),
            tooltip: "Favorites",
          )
        ],
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
              FormBody(onSubmit: _search),
              SizedBox(height: 16.0),
              Builder(builder: (context) {
                switch (contentState) {
                  case ContentState.RECENT:
                    return RecentSearchList();
                  case ContentState.LOCATIONS:
                    return LocationSelectionList();
                  case ContentState.ERROR:
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
  }

  String _getErrorMessage() {
    // TODO Build error message according to the SearchResult
    return "There was a problem with your search";
  }
}
