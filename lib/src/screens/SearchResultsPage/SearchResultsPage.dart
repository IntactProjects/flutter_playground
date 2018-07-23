import 'package:flutter/material.dart';
import 'SearchResultPropertyCell.dart';
import 'package:flutter_playground/models.dart';

class SearchResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("20 of 207 matches"),
      ),
      body: ListView(
        children: _getListData(),
      ),
    );
  }

  _getListData() {
    List<Property> properties = _createProperties();
    List<Widget> widgets = properties
        .map(
          (property) => SearchResultsPropertyCell(
                property: property,
              ),
        )
        .toList();

    return widgets;
  }

  //tmp
  _createProperties() {
    List<Property> properties = [];

    for (int i = 0; i < 100; ++i) {
      properties
          .add(Property(address: "$i rue Royale, Lyon", locality: "France"));
    }

    return properties;
  }
}
