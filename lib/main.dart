import 'package:flutter/material.dart';
import 'src/screens/SearchResultsPage/SearchResultsPage.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/screens.dart';

const USE_MOCK = false;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
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
    if (USE_MOCK) {
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
