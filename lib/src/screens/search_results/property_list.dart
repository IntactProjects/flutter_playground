import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/src/screens/search_results/property_cell/search_result_property_cell.dart';

class PropertyList extends StatefulWidget {
  PropertyListState createState() => PropertyListState();
}

class PropertyListState extends State<PropertyList> {
  StreamController<Property> streamController;
  List<Property> list = [];

  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();
    streamController.stream
        .listen((property) => setState(() => list.add(property)));
    load(streamController);
  }

  void load(StreamController<Property> streamController) async {
    var stream = Stream.empty();
    var propertyService = Provider.of(context).propertyService;
  }

  @override
  void dispose() {
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length + 1,
      itemBuilder: (context, index) => _createElement(context, index),
    );
  }

  Widget _createElement(BuildContext context, int index) {
    if (index < list.length) {
      return _createPropertyCell(context, list[index]);
    } else {
      return RaisedButton(
          color: Theme.of(context).primaryColor,
          elevation: 4.0,
          splashColor: Colors.grey,
          child: Text(
              "Load more … \nResults for #search_term#, showing x of y properties"),
          onPressed: () {
            print("Load Data");
          });
    }
  }

  Widget _createPropertyCell(BuildContext context, Property property) {
    var onTap = (Property property) =>
        AppNavigator.goToPropertyDetails(context, property);
    return SearchResultsPropertyCell(
      property: property,
      onTap: onTap,
    );
  }
}
