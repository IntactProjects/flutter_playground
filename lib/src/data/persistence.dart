import 'dart:async';
import 'dart:convert';

import 'package:flutter_playground/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Persistence {
  static const _FAVORITES = 'FAVORITES';
  static const _RECENTS = 'RECENTS';

  Future<List<String>> get favorites async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_FAVORITES);
  }

  Future setFavorites(List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_FAVORITES, value);
  }

  Future<List<RecentSearch>> get recents async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
        .getStringList(_RECENTS)
        .map((serialized) => RecentSearch.fromJson(json.decode(serialized)));
  }

  Future setRecents(List<RecentSearch> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_RECENTS, value.map((r) => json.encode(r)).toList());
  }
}
