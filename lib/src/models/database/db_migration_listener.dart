import 'package:sqflite/sqflite.dart';

abstract class DatabaseMigrationListener {
  void onCreate(Database db, int version);

  void onUpgrade(Database db, int oldVersion, int newVersion);
}

class AppDatabaseMigrationListener implements DatabaseMigrationListener {
  static const int VERSION_1 = 1;

  @override
  void onCreate(Database db, int version) async {
    print('onCreate version : $version');
    await _createDatabase(db, version);
  }

  @override
  void onUpgrade(Database db, int oldVersion, int newVersion) {
    print('oldVersion : $oldVersion');
    print('newVersion : $newVersion');
  }

  Future<void> _createDatabase(Database db, int version) async {
    if (VERSION_1 == version) {
      await db.execute(
          "CREATE TABLE Word(id INTEGER PRIMARY KEY,"
              " word TEXT, p_all TEXT, noun TEXT, verb TEXT)");
    }
  }
}
