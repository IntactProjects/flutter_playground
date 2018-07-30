import 'package:flutter/material.dart';
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
      propertyService:
          USE_MOCK ? MockPropertyService() : PropertyService(HttpClient()),
      child: new MaterialApp(
        title: 'Property Cross',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
