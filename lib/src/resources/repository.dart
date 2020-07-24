import 'dart:async';

import 'db_helper.dart';
import '../models/database/word_db.dart' show WordDB;
import '../models/search/search_cache.dart';
import '../models/search/search_detail.dart' show SearchJson;
import '../models/word_json.dart' show WordJson;
import '../resources/word_api_provider.dart';

class Repository {
  WordApiProvider wordApiProvider;
  SearchCache cache;
  DatabaseHelper dbHelper;
  WordDB word_recent;

  Repository(this.wordApiProvider, this.cache, this.dbHelper);

  Future<WordJson> fetchWordAPI(String word) async =>
      await wordApiProvider.fetchWord(word);

  Future<SearchJson> searchWordAPI(String query) async {
    if (cache.contains(query)) {
      return cache.get(query);
    } else {
      final result = await wordApiProvider.searchWord(query);
      cache.set(query, result);
      return result;
    }
  }

  Future<List<WordDB>> getWordDB() async => await dbHelper.getWords();

  void saveWordToDB(WordDB w) {
    dbHelper.saveWord(word_recent);
  }

  void deleteWordsFromDB(WordDB w) {
    dbHelper.deleteWords(word_recent);
  }
}

final repository =
    Repository(WordApiProvider(), SearchCache(), DatabaseHelper());
