import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Property property;

  const PropertyDetailsPage({@required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details"),
      ),
      body: SafeArea(
        child: Container(
          child: Text("${property.address}"),
        ),
      ),
    );
  }
}
