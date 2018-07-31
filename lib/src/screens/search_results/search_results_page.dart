import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/src/screens/search_results/property_cell/search_result_property_cell.dart';

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
        child: ListView.builder(
          itemCount: result.properties.length + 1,
          itemBuilder: (context, index) {
            if (index < result.properties.length) {
              return _createPropertyCell(
                  context, result.properties.toList()[index]);
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
          },
        ),
      ),
    );
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
