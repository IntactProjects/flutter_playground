import 'package:flutter/widgets.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/src/data/property_service.dart';

class Provider extends InheritedWidget {
  static Provider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Provider);

  final propertyService = PropertyService(HttpClient());

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
