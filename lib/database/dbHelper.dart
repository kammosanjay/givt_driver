import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //sigleton
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";
  static final String COLUMN_USER = "userName";
  static final String COLUMN_PASS = "password";

  Database? myDB;

  //
  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database> openDB() async {
    try {
      Directory dirpath = await getApplicationDocumentsDirectory();
      String dbPath = join(dirpath.path, 'mydb.db');
      // await deleteDatabase(dbPath);

      return await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE $TABLE_NOTE ("
            "$COLUMN_NOTE_SNO INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$COLUMN_NOTE_TITLE TEXT, "
            "$COLUMN_NOTE_DESC TEXT, "
            "$COLUMN_USER TEXT, "
            "$COLUMN_PASS TEXT"
            ")",
          );
          
          
        },
      );
    } catch (e) {
      throw Exception("Failed to open database: $e");
    }
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.getDB();
    return await db.insert(TABLE_NOTE, row);
  }

  //query

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await instance.getDB();
    List<Map<String, dynamic>> allRows = await db.query(TABLE_NOTE);

    return allRows;
  }

  //delete
  Future<int> delete(int id) async {
    Database db = await instance.getDB();
    return await db
        .delete(TABLE_NOTE, where: '$COLUMN_NOTE_SNO = ?', whereArgs: [id]);
  }

  //update
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.getDB();
    int id = row[COLUMN_NOTE_SNO];
    return await db.update(TABLE_NOTE, row,
        where: '$COLUMN_NOTE_SNO = ?', whereArgs: [id]);
  }
}
