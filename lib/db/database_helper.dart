// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:todo_clear/db/db_consts.dart';
//
// class DatabaseHelper {
//   static Future database() async {
//     final databasePath = await getDatabasesPath();
//
//     return openDatabase(join(databasePath, dDatabaseName),
//         onCreate: (database, version) async {
//       Batch batch = database.batch();
//       batch.execute(createTaskTable);
//       batch.execute(createCollectionTable);
//       await batch.commit();
//     }, version: 1);
//   }
//
//   static Future<void> insert(String table, Map<String, Object> data) async {
//     print('Inserting data');
//     final db = await DatabaseHelper.database();
//     db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   static Future<List<Map<String, Object?>>> getData(String table) async {
//     final db = await DatabaseHelper.database();
//
//     List<Map<String, Object?>> list = await db.query(table);
//     return list;
//   }
//
//   static Future delete(String table, int id) async {
//     print('Deleting task');
//     final database = await DatabaseHelper.database();
//     return database.delete(table, where: 'id = ?', whereArgs: [id]);
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart' as p;

import 'db_consts.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper
          ._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = p.join(databasePath, dDatabaseName);

    //open/create database at a given path
    var taskDb =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return taskDb;
  }

  void _createDb(Database db, int newVersion) async {
    Batch batch = db.batch();
    batch.execute(createTaskTable);
    batch.execute(createCollectionTable);
    await batch.commit();
  }
}
