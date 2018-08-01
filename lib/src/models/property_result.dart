import 'package:flutter_playground/models.dart';

class PropertyResult {
  final int totalResults;
  final int page;
  final Iterable<Property> properties;

  const PropertyResult({
    this.properties = const [],
    this.page = 0,
    this.totalResults = 0,
  });

  bool get isEmpty => properties.isEmpty;
}
