import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/screens/search_results/property_list.dart';

class SearchResultsPage extends StatelessWidget {
  final PropertyResult result;

  const SearchResultsPage({@required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("20 of ${result.properties.length} matches"),
      ),
      body: SafeArea(
        child: PropertyList(),
      ),
    );
  }
}
