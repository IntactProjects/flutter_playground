import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/screens/property_details/favorite_button/favorite_button.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Property property;

  const PropertyDetailsPage({Key key, @required this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details"),
        actions: <Widget>[
          FavoritePropertyButton(property: property),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "${property.price} Euros",
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "${property.address}",
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10.0),
                  Image.network(
                    property.image.toString(),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "${property.bedrooms} beds, ${property.bathrooms} bathrooms",
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "${property.summary}",
                    textAlign: TextAlign.start,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
