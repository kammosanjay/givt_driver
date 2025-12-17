import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  //

  final String TABLE_NAME = "notes";
  final String COLUMN_NOTE_SNO = "id";
  final String COLUMN_NOTE_TITLE = "title";
  final String COLUMN_NOTE_DESC = "description";

  // singleton
  DataBaseHelper._privateConstructor();

  static final DataBaseHelper getInstance =
      DataBaseHelper._privateConstructor();

  Database? myDB;

  //
  Future<Database> getDb() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database?> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    var path = join(directory.path, "myDataBase.db");

    return await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $TABLE_NAME ("
          "$COLUMN_NOTE_SNO INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$COLUMN_NOTE_TITLE TEXT, "
          "$COLUMN_NOTE_DESC TEXT"
          ")",
        );
      },
      version: 1,
    );
  }

  insert() async {
    Database db = await getInstance.getDb();
    await db.insert(TABLE_NAME, {
      "title": "Name",
      "description": "helo how are you",  
    });
  }

  fetch() async {
    Database db = await getInstance.getDb();
    List<Map<String, dynamic>> list = await db.query(TABLE_NAME);
    return list;
  }
}
