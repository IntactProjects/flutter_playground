import 'dart:async';

import 'package:flutter_playground/models.dart';
import 'package:meta/meta.dart';

class HistoryService {
  Future<List<RecentSearch>> getRecentSearches({int maxCount}) {
    // TODO Implement getRecentSearches
    return Future.delayed(Duration(milliseconds: 400), () => []);
  }

  Future saveSearch(String query, SearchResult searchResult) {
    // TODO Implement saveSearch
    if (searchResult.type == ResultType.SUCCESSFUL) {
      var recentSearch = RecentSearch(
        query: query,
        resultCount: searchResult.properties.length,
      );
      return Future.delayed(Duration(milliseconds: 500));
    } else {
      return Future.value(null);
    }
  }

  Future purgeOldSearches({@required int keep}) {
    // TODO Implement purgeOldSearches
    return Future.delayed(Duration(milliseconds: 400), () => []);
  }
}
