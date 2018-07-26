import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/src/screens/home/form_body.dart';

class HomePage extends StatelessWidget {
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
              FormBody(onSubmit: _search)
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
}
