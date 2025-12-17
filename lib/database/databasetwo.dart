import 'dart:io';
import 'package:givt_driver_app/database/modal.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasetwo {
  Databasetwo._privateconstructor();
  static final Databasetwo instance = Databasetwo._privateconstructor();

  static Database? _database;

  Future<Database> getDB() async {
    if (_database != null) return _database!;
    _database = await _openDB();
    return _database!;
  }

  Future<Database> _openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = join(appDir.path, "myDatabase.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE MYTABLE (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            contact INTEGER,
            address TEXT,
            gender CHAR
          )
        ''');
      },
    );
  }

  //
  //
  Future<int> insertdata(StudentModal studentModal) async {
    Database db = await instance.getDB();

    int rowaffected = await db.insert('MYTABLE', {
      "name": studentModal.name,
      "contact": studentModal.contact,
      'address': studentModal.address,
      'gender': studentModal.gender,
    });

    print(rowaffected);

    return rowaffected;
  }

  //
  //

  Future<List<Map<String, dynamic>>> fetch() async {
    Database db = await instance.getDB();
    List<Map<String, dynamic>> list = await db.query('MYTABLE');
    return list;
  }
  //
  //

  update({int? id}) async {
    Database db = await instance.getDB();
    await db.update(
      'MYTABLE',
      {'NAME': "HELLO", "CONTACT": 2342},
      where: "SERIAL_NUM=? AND  NAME=? AND CONTACT=? ",
      whereArgs: [id],
    );
  }
}
