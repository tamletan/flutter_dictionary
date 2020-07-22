import 'dart:async';

import '../models/search/search_detail.dart' show SearchDetail;
import '../models/word_detail.dart' show WordDetail;

class Repository {
  final wordApiProvider;
  final cache;

  Repository(this.wordApiProvider, this.cache);

  Future<WordDetail> fetchWordAPI(String word) =>
      wordApiProvider.fetchWord(word);

  Future<SearchDetail> searchWordAPI(String query) async {
    if (cache.contains(query)) {
      return cache.get(query);
    } else {
      final result = await wordApiProvider.searchWord(query);
      cache.set(query, result);
      return result;
    }
  }
}
