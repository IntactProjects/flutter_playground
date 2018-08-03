import 'dart:async';
import 'dart:convert';

import 'package:flutter_playground/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Persistence {
  static const _FAVORITES = 'FAVORITES';
  static const _RECENTS = 'RECENTS';

  Future<List<Property>> get favorites async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_FAVORITES) ?? [])
        .map((serialized) => Property.fromJson(json.decode(serialized)))
        .toList();
  }

  Future setFavorites(List<Property> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        _FAVORITES, (value ?? []).map((p) => json.encode(p)).toList());
  }

  Future<List<RecentSearch>> get recents async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_RECENTS) ?? [])
        .map((serialized) => RecentSearch.fromJson(json.decode(serialized)))
        .toList();
  }

  Future setRecents(List<RecentSearch> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      _RECENTS,
      value.map((r) => json.encode(r)).toList(),
    );
  }
}
