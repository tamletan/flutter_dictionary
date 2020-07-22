import '../search/search_detail.dart' show SearchDetail;

class SearchCache {
  final _cache = <String, SearchDetail>{};

  SearchDetail get(String term) => _cache[term];

  void set(String term, SearchDetail detail) => _cache[term] = detail;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}