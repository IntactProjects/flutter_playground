import 'dart:async';

import 'package:flutter_playground/infra.dart';
import 'package:flutter_playground/models.dart';
import 'package:meta/meta.dart';

class RecentService {
  final Persistence persistence;

  RecentService(this.persistence);

  Future<List<RecentSearch>> getRecentSearches({int maxCount}) async {
    var recents = await persistence.recents
      ..sort(_recentsComparator);
    return recents.take(maxCount).toList();
  }

  Future saveSearch(String query, SearchResult searchResult) async {
    if (searchResult.type == ResultType.SUCCESSFUL) {
      var recents = await persistence.recents;
      var latestSearch = RecentSearch(
        query: query,
        resultCount: searchResult.properties.length,
      );
      // TODO Check if latestSearch already exists
      recents.add(latestSearch);
      persistence.setRecents(recents);
    }
  }

  Future purgeOldSearches({@required int keep}) async {
    var recents = await persistence.recents
      ..sort(_recentsComparator);
    var survivors = recents.take(keep);
    persistence.setRecents(survivors);
  }
}

final _recentsComparator = (RecentSearch r1, RecentSearch r2) =>
    r1.searchDate.compareTo(r2.searchDate);
