import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/widgets.dart';

class FavoritesPage extends StatefulWidget {
  @override
  FavoritesPageState createState() {
    return new FavoritesPageState();
  }
}

class FavoritesPageState extends State<FavoritesPage> {
  FavoriteService favoriteService;
  StreamController<List<Property>> streamController;
  List<Property> list;

  @override
  void initState() {
    super.initState();
    list = [];
    streamController = StreamController.broadcast()
      ..stream.listen((properties) => setState(() {
            list = properties;
          }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    favoriteService = Provider.of(context).favoriteService;
    load();
  }

  void load() async {
    var properties = await favoriteService.favorites;
    streamController.add(properties);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: SafeArea(
        child: _createElement(list),
      ),
    );
  }

  Widget _createElement(List<Property> properties) {
    return properties.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "You have not added any properties to your favourites",
                textAlign: TextAlign.center,
              ),
            ),
          )
        : PropertyList(
            list: properties,
            isLoading: false,
            isLoadMoreEnabled: false,
          );
  }
}
