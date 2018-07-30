import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/src/screens/PropertyDetailsPage/PropertyDetailsPage.dart';
import 'package:flutter_playground/src/screens/SearchResultsPage/SearchResultsPage.dart';

class AppNavigator {
  AppNavigator._();

  static void goToFavorites(BuildContext context) {
    Navigator.of(context).pushNamed(NamedRoutes.FAVORITES);
  }

  static void goToSearchResults(
      BuildContext context, List<Property> properties) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResultsPage(properties: properties)));
  }

  static void goToPropertyDetails(BuildContext context, Property property) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PropertyDetailsPage(property: property)),
    );
  }
}
