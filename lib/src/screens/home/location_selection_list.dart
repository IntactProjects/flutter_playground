import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';

class LocationSelectionList extends StatelessWidget {
  final List<Location> candidates;

  const LocationSelectionList({@required this.candidates});

  @override
  Widget build(BuildContext context) {
    return Text("Locations");
  }
}
