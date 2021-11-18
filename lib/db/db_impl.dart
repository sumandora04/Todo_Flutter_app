import 'package:sqflite/sqflite.dart';
import 'package:todo_clear/db/database_helper.dart';
import 'package:todo_clear/db/db_consts.dart';
import 'package:todo_clear/db/i_collection.dart';
import 'package:todo_clear/db/i_task.dart';
import 'package:todo_clear/model/task.dart';
import 'package:todo_clear/model/task_collection.dart';

class DbImpl implements ITask, ICollection {
  DatabaseHelper helper = DatabaseHelper();
  Database? database;

  initDatabase() {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((value) => database = value);
  }

  @override
  Future<int> deleteItem(String table, int id, String colName) async {
    var db = await helper.database;
    int result = await db.rawDelete('DELETE FROM $table WHERE $colName = $id');
    return result;
  }

  @override
  Future<int> getItemCount(String table) async {
    Database db = await helper.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table');
    int result = Sqflite.firstIntValue(x) ?? 0;
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> getTaskListMap(
      int colId) async {
    Database db = await helper.database;
    var list = await db.rawQuery('SELECT * FROM $dTaskTable WHERE $dCollectionId = $colId');
    return list;

  }

  @override
  Future<int> insertTask(Task task) async {
    Database db = await helper.database;
    var result = await db.insert(dTaskTable, task.toMap());
    return result;
  }

  @override
  Future<int> updateTask(Task task) async {
    var db = await helper.database;
    var result = await db.update(dTaskTable, task.toMap(),
        where: '$dTaskId = ?', whereArgs: [task.id]);
    return result;
  }

  @override
  Future<int> insertCollection(TaskCollection coll) async {
    Database db = await helper.database;
    var result = await db.insert(dCollectionTable, coll.toMap());
    return result;
  }

  @override
  Future<int> updateCollection(TaskCollection coll) async {
    var db = await helper.database;
    var result = await db.update(dCollectionTable, coll.toMap(),
        where: '$dTaskId = ?', whereArgs: [coll.id]);
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> getCollectionListMap() async{
    Database db = await helper.database;
    var list = await db.query(dCollectionTable);
    return list;
  }
}
