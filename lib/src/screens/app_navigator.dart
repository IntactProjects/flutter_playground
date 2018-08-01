import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/src/screens/property_details/property_details_page.dart';
import 'package:flutter_playground/src/screens/search_results/search_results_page.dart';

class AppNavigator {
  AppNavigator._();

  static void goToFavorites(BuildContext context) {
    Navigator.of(context).pushNamed(NamedRoutes.FAVORITES);
  }

  static void goToSearchResults(BuildContext context, SearchResult result) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResultsPage(result: result)));
  }

  static void goToPropertyDetails(BuildContext context, Property property) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PropertyDetailsPage(property: property)),
    );
  }
}
