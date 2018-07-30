import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/screens/PropertyDetailsPage/PropertyDetailsPage.dart';
import 'package:flutter_playground/src/screens/SearchResultsPage/PropertyCell/SearchResultPropertyCell.dart';
import 'package:flutter_playground/src/screens/app_navigator.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Property> properties;

  const SearchResultsPage({@required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("20 of ${properties.length} matches"),
      ),
      body: SafeArea(
        child: ListView(
          children: _getListData(context),
        ),
      ),
    );
  }

  List<Widget> _getListData(BuildContext context) {
    var onTap = (Property property) =>
        AppNavigator.goToPropertyDetails(context, property);
    var widgets = properties
        .map((property) => SearchResultsPropertyCell(
              property: property,
              onTap: onTap,
            ))
        .toList();

    return widgets;
  }

  //tmp
  // List<Property> _createProperties() {
  //   var properties = <Property>[];

  //   for (int i = 0; i < 100; ++i) {
  //     properties.add(Property(
  //         address: "$i rue Royale, Lyon",
  //         locality: "France",
  //         price: 333333.0,
  //         image: Uri.https("i.ytimg.com", "vi/fq4N0hgOWzU/maxresdefault.jpg")));
  //   }

  //   return properties;
  // }
}
