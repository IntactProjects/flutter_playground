import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';

class SearchResultsPropertyCell extends StatelessWidget {
  final Property property;
  const SearchResultsPropertyCell({@required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${property.address}, ${property.locality}"),
    );
  }
}
