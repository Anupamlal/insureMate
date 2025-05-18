import 'dart:io';

import 'package:insure_mate/db_helper/dao/person_dao.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();
  static final String APP_DB_NAME = "insuremate.db";
  static Database? _appDB;

  Future<Database> getDB() async {
    return _appDB ?? _openDB();
  }

  Future<Database> _openDB() async {
    Directory dirPath = await getApplicationDocumentsDirectory();
    String dbPath = join(dirPath.path, APP_DB_NAME);

    print("DB Path is $dbPath");

    return await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await _createPersonTable(db);
      },
      version: 1,
    );
  }

  Future<void> _createPersonTable(Database db) async {
    return await db.execute('''create table ${PersonDao.PERSON_TABLE} (
        id integer primary key autoincrement,
        ${PersonDao.COLUMN_PERSON_ID} integer,
        ${PersonDao.COLUMN_FULL_NAME} text,
        ${PersonDao.COLUMN_EMAIL} text,
        ${PersonDao.COLUMN_PROFILE_PHOTO_URL} text
        )''');
  }
}
