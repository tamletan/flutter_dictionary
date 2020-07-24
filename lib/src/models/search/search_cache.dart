import '../search/search_detail.dart' show SearchJson;

class SearchCache {
  final _cache = <String, SearchJson>{};

  SearchJson get(String term) => _cache[term];

  void set(String term, SearchJson detail) => _cache[term] = detail;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}