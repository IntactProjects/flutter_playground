import 'package:flutter/material.dart';

typedef void LoadMoreButtonCallback();

class LoadMoreButton extends StatelessWidget {
  final bool isLoading;
  final LoadMoreButtonCallback callback;

  LoadMoreButton({Key key, this.isLoading, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = isLoading ? "Loading..." : "Load more...";
    var callback = isLoading ? null : this.callback;

    return RaisedButton(
        color: Theme.of(context).primaryColor,
        elevation: 4.0,
        splashColor: Colors.grey,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          callback();
        });
  }
}
