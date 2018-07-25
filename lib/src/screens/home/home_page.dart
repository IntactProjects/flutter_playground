import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var propertyService = Provider.of(context).propertyService;
    if (propertyService == null) throw StateError("propertyService is null");
    return Center(
      child: Text("HOME"),
    );
  }
}