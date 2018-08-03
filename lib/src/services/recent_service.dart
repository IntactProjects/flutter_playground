import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:meta/meta.dart';

class RecentService {
  final Persistence persistence;
  final _log = Logger('RecentService');

  RecentService(this.persistence);

  Future<List<RecentSearch>> getRecentSearches({int maxCount}) async {
    var recents = await persistence.recents
      ..sort(_recentsComparator);
    return recents.take(maxCount).toList();
  }

  Future saveSearch(query, SearchResult searchResult) async {
    if (searchResult.type == ResultType.SUCCESSFUL) {
      String label;
      if (query is Location) {
        label = query.label;
      } else if (query is Geolocation) {
        _log.warning('Geolocation search. Check the returned location(s)');
        label = _getSearchLabelFromResult(searchResult);
        if (query == null) {
          return;
        }
      }

      var recents = await persistence.recents;
      var latestSearch = RecentSearch(
        label: label,
        query: query,
        resultCount: searchResult.propertyResult.totalResults,
      );

      // Replace any previous search with the new one
      recents
        ..removeWhere((s) => s.query == query)
        ..add(latestSearch);
      persistence.setRecents(recents);
    }
  }

  Future purgeOldSearches({@required int keep}) async {
    var recents = await persistence.recents
      ..sort(_recentsComparator);
    var survivors = recents.take(keep);
    persistence.setRecents(survivors);
  }

  String _getSearchLabelFromResult(SearchResult result) {
    if (result.locations != null && result.locations.isNotEmpty) {
      var location = result.locations.first;
      return location.label;
    } else {
      return null;
    }
  }
}

// Reverse chronological order
final _recentsComparator = (RecentSearch r1, RecentSearch r2) =>
    r2.searchDate.compareTo(r1.searchDate);
