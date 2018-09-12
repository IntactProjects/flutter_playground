import 'package:flutter/material.dart';
import 'package:flutter_playground/models.dart';
import 'package:flutter_playground/screens.dart';
import 'package:flutter_playground/widgets.dart';

typedef void PropertyListCallback();

class PropertyList extends StatelessWidget {
  final List<Property> list;
  final bool isLoading;
  final bool isLoadMoreEnabled;
  final PropertyListCallback callback;

  const PropertyList({
    Key key,
    @required this.list,
    @required this.isLoading,
    @required this.isLoadMoreEnabled,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var count = isLoadMoreEnabled ? list.length + 1 : list.length;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) =>
          _createElement(context, index, isLoading),
    );
  }

  Widget _createElement(BuildContext context, int index, isLoading) {
    if (index < list.length) {
      return _createPropertyCell(context, list[index]);
    } else {
      return LoadMoreButton(isLoading: isLoading, callback: callback);
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
