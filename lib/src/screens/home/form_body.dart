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
  final TextEditingController _searchController = TextEditingController();
  bool get isSearchValid => _searchController.text.isNotEmpty;

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
        ),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text("Go"),
              onPressed: isSearchValid
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
