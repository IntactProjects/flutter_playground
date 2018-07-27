import 'package:flutter/widgets.dart';

class Provider extends InheritedWidget {
  static Provider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Provider);

  final propertyService;

  Provider({Key key, @required this.propertyService, Widget child})
      : assert(propertyService != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
