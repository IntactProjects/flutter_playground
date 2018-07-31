import 'package:meta/meta.dart';

class RecentSearch {
  final String query;
  final int resultCount;
  final DateTime searchDate;

  RecentSearch({
    @required this.query,
    @required this.resultCount,
    DateTime searchDate,
  })  : assert(query != null),
        assert(resultCount != null),
        searchDate = searchDate ?? DateTime.now();
}
