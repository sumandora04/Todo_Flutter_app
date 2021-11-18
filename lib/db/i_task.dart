
import 'package:todo_clear/db/i_common_operation.dart';
import 'package:todo_clear/model/task.dart';

abstract class ITask extends ICommonOperation{
  Future<List<Map<String, dynamic>>> getTaskListMap(int colId);
  Future<int> insertTask(Task data);
  Future<int> updateTask(Task data);
}