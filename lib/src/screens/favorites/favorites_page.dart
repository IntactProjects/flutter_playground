import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/widgets.dart';

class FavoritesPage extends StatefulWidget {
  @override
  FavoritesPageState createState() {
    return new FavoritesPageState();
  }
}

class FavoritesPageState extends State<FavoritesPage> {
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
    // propertyService = Provider.of(context).propertyService;
  }

  void load() async {
    // var result = await propertyService.search(widget.initialSearchResult.query,
    //     page: ++page);
    streamController.add([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: SafeArea(
        child: PropertyList(
          list: list,
          isLoading: false,
          isLoadMoreEnabled: false,
        ),
      ),
    );
  }
}
