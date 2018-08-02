import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';

typedef void FavoriteButtonCallback(bool favorite);

class FavoritePropertyButton extends StatelessWidget {
  final Property property;

  FavoritePropertyButton({
    Key key,
    this.property,
  }) : super(key: key);

  void handleFavorites(BuildContext context, bool isFavorite) {
    Provider.of(context).favoriteService.setFavorite(property, isFavorite);
  }

  Future<bool> isFavorite(BuildContext context) {
    return Provider.of(context).favoriteService.isFavorite(property);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFavorite(context),
      initialData: false,
      builder: (context, snap) {
        return FavoriteButton(
          initialFavorite: snap.data,
          callback: (favorite) {
            handleFavorites(context, favorite);
          },
        );
      },
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final bool initialFavorite;
  final FavoriteButtonCallback callback;

  const FavoriteButton({
    Key key,
    this.initialFavorite,
    this.callback,
  }) : super(key: key);

  @override
  FavoriteButtonState createState() {
    return FavoriteButtonState();
  }
}

class FavoriteButtonState extends State<FavoriteButton> {
  bool favorite;

  @override
  void initState() {
    super.initState();
    favorite = widget.initialFavorite;
  }

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    favorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    var icon = favorite ? Icons.star : Icons.star_border;
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        setState(() {
          widget.callback(favorite);
          favorite = !favorite;
        });
      },
    );
  }
}
