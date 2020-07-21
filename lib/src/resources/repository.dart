import 'dart:async';

import '../models/search_detail.dart';
import '../models/word_detail.dart';

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
