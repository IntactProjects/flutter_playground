import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/widgets.dart';

typedef void PropertyCallback(Property property);

class SearchResultsPropertyCell extends StatelessWidget {
  final Property property;
  final PropertyCallback onTap;

  const SearchResultsPropertyCell(
      {Key key, @required this.property, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(property),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ImageHero.fromImage(
                tag: property.id,
                image: property.thumb,
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
