
import 'package:todo_clear/db/i_common_operation.dart';
import 'package:todo_clear/db/i_task.dart';
import 'package:todo_clear/model/task_collection.dart';

abstract class ICollection extends ICommonOperation{
  Future<List<Map<String, dynamic>>> getCollectionListMap();
  Future<int> insertCollection(TaskCollection data);
  Future<int> updateCollection(TaskCollection data);
}