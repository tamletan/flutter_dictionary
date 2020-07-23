import 'dart:async';

import '../models/database/db_helper.dart';
import '../models/database/word_db.dart' show HistoryWord;
import '../models/search/search_cache.dart';
import '../models/search/search_detail.dart' show SearchDetail;
import '../models/word_detail.dart' show WordDetail;
import '../resources/word_api_provider.dart';

class Repository {
  WordApiProvider wordApiProvider;
  SearchCache cache;
  DatabaseHelper dbHelper;

  Repository(this.wordApiProvider, this.cache, this.dbHelper);

  Future<WordDetail> fetchWordAPI(String word) async =>
      await wordApiProvider.fetchWord(word);

  Future<SearchDetail> searchWordAPI(String query) async {
    if (cache.contains(query)) {
      return cache.get(query);
    } else {
      final result = await wordApiProvider.searchWord(query);
      cache.set(query, result);
      return result;
    }
  }

  Future<List<HistoryWord>> getWordDB() async => await dbHelper.getWords();
}

final repository =
    Repository(WordApiProvider(), SearchCache(), DatabaseHelper());
