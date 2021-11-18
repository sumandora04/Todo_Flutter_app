import 'package:flutter/foundation.dart';
import 'package:todo_clear/db/db_consts.dart';
import 'package:todo_clear/db/db_impl.dart';
import 'package:todo_clear/db/i_task.dart';
import 'package:todo_clear/model/task.dart';
import 'package:todo_clear/util.dart';

class TaskProvider with ChangeNotifier {
  final ITask _iTask = DbImpl();
  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  int get taskCount {
    return _tasks.length;
  }

  // void checkOfTask(Task task) {
    // task.toggleIsDone();
    // deleteTask(task);
    // updateTask(task);
    // insertOrUpdateTask(task.id, task.title, EditMode.UPDATE);
    // notifyListeners();
  // }

  void updateTask(Task task) {
    _tasks.add(
      Task(
        id: DateTime.now().millisecond,
        title: task.title,
        isDone: task.isDone,
        colId: task.colId,
      ),
    );
    notifyListeners();
  }

  void reOrderTask(int oldIndex, int newIndex) {
    final movedTask = _tasks.removeAt(oldIndex);
    int lastIndex = taskCount;

    if (newIndex > oldIndex) {
      var lastTask = _tasks[lastIndex - 1];
      if (lastIndex <= (newIndex)) {
        if (lastTask.isDone==1) {
          movedTask.toggleIsDone();
        }
      }
      _tasks.insert(newIndex - 1, movedTask);
      _iTask.updateTask(movedTask);
    } else {
      _tasks.insert(newIndex, movedTask);
    }
    notifyListeners();
  }

  /***********************************************************************/

  Future<List<Task>> getTasks(int collectionId) async {
    List<Map<String, dynamic>> list =
    await _iTask.getTaskListMap(collectionId);
    _tasks =
        list.map((item) => Task.fromMapObject(item)).toList();
    notifyListeners();
    return tasks;
  }

  Future insertOrUpdateTask(
      Task task, EditMode editMode) async {
    // final task = Task(id: id, title: title);

    if (EditMode.ADD == editMode) {
      _tasks.insert(0, task);
      _iTask.insertTask(task);
    } else {
      // _tasks[_tasks.indexWhere((t) => t.id == taskCount-1)] = task;
      _tasks.remove(task);
      task.toggleIsDone();
      Task temp = Task(id: task.id,colId: task.colId, title: task.title,isDone: 1);
      _tasks.add(temp);
      _iTask.updateTask(temp);
    }
    notifyListeners();
  }

  Future deleteTask(Task task) {
    _tasks.removeWhere((element) => element.id == task.id);
    notifyListeners();
    return _iTask.deleteItem(dTaskTable, task.id, dTaskId);
  }

}
