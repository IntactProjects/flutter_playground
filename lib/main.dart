import 'package:flutter/material.dart';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/screens.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    LoggerConfig().attach();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
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
