import 'dart:async';

import 'package:flutter_playground/models.dart';

class FavoriteService {
  Future<bool> isFavorite(Property property) {
    // TODO Implement isFavorite
    return Future.delayed(Duration(milliseconds: 500), () => false);
  }

  Future setFavorite(Property property, bool favorite) {
    // TODO Implement setFavorite
    return Future.delayed(Duration(milliseconds: 400));
  }
}
