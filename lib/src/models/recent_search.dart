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

  RecentSearch.fromJson(Map<String, dynamic> json)
      : query = json['query'],
        resultCount = json['resultCount'],
        searchDate = DateTime.parse(json['searchDate']);

  Map<String, dynamic> toJson() => {
        'query': query,
        'resultCount': resultCount,
        'searchDate': searchDate.toIso8601String(),
      };
}
