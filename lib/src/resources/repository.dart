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

  Future<WordJson> fetchWord(String word) async {
    WordJson data;
    if (dbHelper.contains(word)) {
      data = await dbHelper.getWord(word).toWordJson();
      data.setFavor(true);
    } else {
      data = await wordApiProvider.fetchWord(word);
      data.setFavor(false);
    }
    return data;
  }
}

final repository =
    Repository(WordApiProvider(), SearchCache(), DatabaseHelper());
