import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/src/screens/search_results/load_more_button/load_more_button.dart';
import 'package:flutter_playground/src/screens/search_results/property_cell/search_result_property_cell.dart';

class SearchResultsPage extends StatefulWidget {
  final SearchResult initialSearchResult;

  const SearchResultsPage({Key key, @required result})
      : assert(result != null),
        initialSearchResult = result,
        super(key: key);

  @override
  SearchResultsPageState createState() {
    return new SearchResultsPageState();
  }
}

class SearchResultsPageState extends State<SearchResultsPage> {
  PropertyService propertyService;
  StreamController<PropertyResult> streamController;
  List<Property> list = [];
  int page;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    page = widget.initialSearchResult.propertyResult.page;
    list = widget.initialSearchResult.propertyResult.properties.toList();
    streamController = StreamController.broadcast();
    streamController.stream.listen((propertyResult) => setState(() {
          page = propertyResult.page;
          list.addAll(propertyResult.properties);
          isLoading = false;
        }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    propertyService = Provider.of(context).propertyService;
  }

  void load() async {
    setState(() {
      isLoading = true;
    });

    var result = await propertyService.search(widget.initialSearchResult.query,
        page: ++page);
    streamController.add(result.propertyResult);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${list.length} of ${widget.initialSearchResult.propertyResult.totalResults} matches"),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: list.length + 1,
        itemBuilder: (context, index) => _createElement(context, index),
      )),
    );
  }

  Widget _createElement(BuildContext context, int index) {
    if (index < list.length) {
      return _createPropertyCell(context, list[index]);
    } else {
      return LoadMoreButton(isLoading: isLoading, callback: load);
    }
  }

  Widget _createPropertyCell(BuildContext context, Property property) {
    var onTap = (Property property) =>
        AppNavigator.goToPropertyDetails(context, property);
    return SearchResultsPropertyCell(
      property: property,
      onTap: onTap,
    );
  }
}
