import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/screens/app_navigator.dart';
import 'package:flutter_playground/src/screens/search_results/property_cell/search_result_property_cell.dart';

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
}
