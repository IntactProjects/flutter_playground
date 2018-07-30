import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';

typedef void PropertyCallback(Property property);

class SearchResultsPropertyCell extends StatelessWidget {
  final Property property;
  final PropertyCallback onTap;

  const SearchResultsPropertyCell({@required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    print(property.image.toString());
    return Card(
      child: InkWell(
        onTap: () => onTap(property),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Image.network(
                property.image.toString(),
                height: 100.0,
                width: 100.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${property.price} euros"),
                      SizedBox(height: 15.0),
                      Text("${property.address}, ${property.locality}"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
