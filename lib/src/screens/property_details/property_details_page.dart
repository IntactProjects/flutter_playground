import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/src/screens/property_details/favorite_button/favorite_button.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Property property;

  const PropertyDetailsPage({@required this.property});

  void handleFavorites(BuildContext context, bool isFavorite) {
    Provider.of(context).favoriteService.setFavorite(property, isFavorite);
  }

  Future<bool> isFavorite(BuildContext context) {
    return Provider.of(context).favoriteService.isFavorite(property);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details"),
        actions: <Widget>[
          FutureBuilder<bool>(
            future: isFavorite(context),
            initialData: false,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                return FavoriteButton(
                  initialFavorite: snap.data,
                  callback: (favorite) {
                    handleFavorites(context, !favorite);
                  },
                );
              }
            },
          )
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
