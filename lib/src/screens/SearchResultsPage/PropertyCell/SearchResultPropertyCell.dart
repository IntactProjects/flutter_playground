import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';

typedef void PropertyCallback(Property property);

class SearchResultsPropertyCell extends StatelessWidget {
  final Property property;
  final PropertyCallback onTap;

  const SearchResultsPropertyCell({@required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(property),
        child: Row(
          children: <Widget>[
            Image.network(
              "https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg",
              height: 100.0,
              width: 100.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${property.price} euros"),
                  SizedBox(height: 15.0),
                  Text("${property.address}, ${property.locality}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
