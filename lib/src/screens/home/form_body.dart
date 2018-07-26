import 'package:flutter/material.dart';

const SEARCH_MY_LOCATION = "MY_LOCATION";
typedef void SearchCallback(BuildContext context, String query);

class FormBody extends StatefulWidget {
  final SearchCallback onSubmit;

  FormBody({Key key, this.onSubmit}) : super(key: key);

  @override
  FormBodyState createState() => FormBodyState();
}

class FormBodyState extends State<FormBody> {
  TextEditingController _searchController;
  bool get validForSearch => _searchController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Address',
            border: OutlineInputBorder(),
          ),
          onChanged: (_) => _refreshState(),
          // BUG: on Android, onSubmitted is not called when pressing the Enter key on a physical keyboard
          onSubmitted: validForSearch
              ? (query) => widget.onSubmit(context, query)
              : null,
        ),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text("Go"),
              onPressed: validForSearch
                  ? () => widget.onSubmit(context, _searchController.text)
                  : null,
            ),
            SizedBox(width: 8.0),
            RaisedButton(
              child: Text("My location"),
              onPressed: () => widget.onSubmit(context, SEARCH_MY_LOCATION),
            )
          ],
        )
      ],
    );
  }

  void _refreshState() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
