import 'package:flutter/material.dart';

class AppBarProgressIndicator extends StatelessWidget {
  const AppBarProgressIndicator({
    Key key,
    @required this.appTheme,
  }) : super(key: key);

  final ThemeData appTheme;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        height: 24.0,
        width: 24.0,
        child: Theme(
          data: appTheme.copyWith(
            accentColor: appTheme.primaryIconTheme.color,
          ),
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
      onPressed: null,
    );
  }
}
