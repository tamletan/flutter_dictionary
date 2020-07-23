import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_config.dart';
import 'db_migration_listener.dart';
import 'word_db.dart';

class DatabaseHelper {
  Database _database;
  DatabaseConfig _databaseConfig;
  List<HistoryWord> _list;

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

  Future<int> saveWord(HistoryWord word) async {
    int res = await _database.insert("Word", word.toMap());
    return res;
  }

  Future<List<HistoryWord>> getWords() async {
    List<Map> list = await _database.rawQuery('SELECT * FROM Word');
    List<HistoryWord> lists = new List();
    for (int i = 0; i < list.length; i++) {
      var user = new HistoryWord(
          word: list[i]["word"],
          all: list[i]["p_all"],
          noun: list[i]["noun"],
          verb: list[i]["verb"]);
      lists.add(user);
    }
    print(lists.length);
    _list = lists;
    return lists;
  }

  Future<int> deleteWords(HistoryWord word) async {
    int res =
        await _database.rawDelete('DELETE FROM Word WHERE word = ?', [word.word]);
    return res;
  }

  Future<bool> update(HistoryWord word) async {
    int res = await _database.update("Word", word.toMap(),
        where: "word = ?", whereArgs: <String>[word.word]);
    return res > 0 ? true : false;
  }

  bool contains(String word){
    for (HistoryWord i in _list){
      if (i.word == word)
        return true;
    }
    return false;
  }
}
