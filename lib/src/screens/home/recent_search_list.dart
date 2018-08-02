import 'package:flutter/material.dart';
import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';

typedef void OnTapSearch(String query);

class RecentSearchList extends StatelessWidget {
  final OnTapSearch onTap;

  const RecentSearchList({this.onTap});

  @override
  Widget build(BuildContext context) {
    var recentService = Provider.of(context).recentService;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Recent Searches'),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 200.0),
            child: FutureBuilder<List<RecentSearch>>(
              future: recentService.getRecentSearches(maxCount: 6),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snap.hasData && snap.data.isNotEmpty) {
                  var items = ListTile.divideTiles(
                    context: context,
                    tiles: snap.data.map((d) => _buildRecentItem(context, d)),
                  );
                  return Column(children: items.toList());
                } else {
                  return Center(
                    child: Text(
                      'No recent search',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentItem(BuildContext context, RecentSearch recent) {
    var textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        recent.label,
        style: textTheme.body2,
      ),
      trailing: Text(
        "${recent.resultCount} results",
        style: textTheme.caption,
      ),
      onTap: onTap != null ? () => onTap(recent.query) : null,
    );
  }
}
