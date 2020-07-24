import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_config.dart';
import 'db_migration_listener.dart';
import 'word_db.dart';

class DatabaseHelper {
  Database _database;
  DatabaseConfig _databaseConfig;
  List<WordDB> _list;

  DatabaseHelper() {
    _databaseConfig =
        DatabaseConfig(1, "Favor_Word", AppDatabaseMigrationListener());
  }

  Future<void> open() async {
    var path = await _getDBPath();

    _database = await openDatabase(path,
        version: _databaseConfig.version,
        onCreate: null != _databaseConfig.databaseMigrationListener
            ? _databaseConfig.databaseMigrationListener.onCreate
            : null,
        onUpgrade: null != _databaseConfig.databaseMigrationListener
            ? _databaseConfig.databaseMigrationListener.onUpgrade
            : null);
  }

  Future<String> _getDBPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, _databaseConfig.dbName);
  }

  Future<void> deleteDB() async {
    var path = await _getDBPath();
    await deleteDatabase(path);
  }

  Future<void> close() async {
    if (null != _database) {
      await _database.close();
    }
  }

  Database get database => _database;

  Future<int> saveWord(WordDB word) async {
    int index = await _database.insert("Word", word.toMap());
    return index;
  }

  Future<List<WordDB>> getWords() async {
    List<Map> list = await _database.rawQuery('SELECT * FROM Word');
    List<WordDB> lists = new List();
    for (int i = 0; i < list.length; i++) {
      var user = new WordDB(
          id: list[i]["id"],
          word: list[i]["word"],
          pronunciation: list[i]["pronunciation"],
          results: list[i]["results"]);
      lists.add(user);
    }
    _list = lists;
    return lists;
  }

  Future<int> deleteWords(WordDB word) async {
    int res = await _database
        .rawDelete('DELETE FROM Word WHERE word = ?', [word.word]);
    return res;
  }

  Future<bool> update(WordDB word) async {
    int res = await _database.update("Word", word.toMap(),
        where: "word = ?", whereArgs: <String>[word.word]);
    return res > 0 ? true : false;
  }

  WordDB getWord(String word) {
    for (WordDB i in _list) {
      if (i.word == word) return i;
    }
    return null;
  }

  bool contains(String word) {
    for (WordDB i in _list) {
      if (i.word == word) return true;
    }
    return false;
  }
}
