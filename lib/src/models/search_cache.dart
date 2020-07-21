import 'search_detail.dart';

class SearchCache {
  final _cache = <String, SearchDetail>{};

  SearchDetail get(String term) => _cache[term];

  void set(String term, SearchDetail detail) => _cache[term] = detail;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}