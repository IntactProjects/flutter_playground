import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text("Go"),
              onPressed: null,
            ),
            SizedBox(width: 8.0),
            RaisedButton(
              child: Text("My location"),
              onPressed: () => _onClick(context, "Clicked 'My location'"),
            )
          ],
        ),
      ],
    );
  }

  void _onClick(BuildContext context, String message) {
    Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
