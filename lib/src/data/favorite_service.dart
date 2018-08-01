import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';

class FavoriteService {
  final Persistence persistence;

  FavoriteService(this.persistence);

  Future<bool> isFavorite(Property property) async {
    return (await persistence.favorites).contains(property.id);
  }

  Future setFavorite(Property property, bool isFavorite) async {
    var favorites = await persistence.favorites;
    if (isFavorite) {
      favorites.removeWhere((id) => id == property.id);
    } else {
      favorites.add(property.id);
    }
    persistence.setFavorites(favorites);
  }
}
