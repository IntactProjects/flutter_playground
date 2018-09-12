import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/widgets.dart';

class FavoritePropertyButton extends StatelessWidget {
  final Property property;

  FavoritePropertyButton({
    Key key,
    this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFavorite(context),
      initialData: false,
      builder: (context, snap) {
        return FavoriteButton(
          initialFavorite: snap.data,
          callback: (favorite) {
            _handleFavorites(context, favorite);
          },
        );
      },
    );
  }

  void _handleFavorites(BuildContext context, bool isFavorite) {
    Provider.of(context).favoriteService.setFavorite(property, isFavorite);
  }

  Future<bool> _isFavorite(BuildContext context) {
    return Provider.of(context).favoriteService.isFavorite(property);
  }
}
