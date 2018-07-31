import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/screens.dart';

class App extends StatelessWidget {
  final bool mock;

  App({this.mock = false}) {
    LoggerConfig().attach();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      config: _buildProviderConfig(),
      child: new MaterialApp(
        title: 'Property Cross',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }

  ProviderConfig _buildProviderConfig() {
    if (mock) {
      return ProviderConfig(
        propertyService: MockPropertyService(),
        geolocationService: MockGeolocationService(),
      );
    } else {
      return ProviderConfig(
        propertyService: PropertyService(HttpClient()),
        geolocationService: GeolocationService(),
      );
    }
  }
}
