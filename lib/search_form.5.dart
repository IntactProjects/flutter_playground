import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  final _textController = TextEditingController();
  bool _goEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _textController,
          onChanged: (text) {
            _goEnabled = text.isNotEmpty;
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text("Go"),
              onPressed: _goEnabled
                  ? () => _onClick(
                      context, "Clicked 'Go' on ${_textController.text}")
                  : null,
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
