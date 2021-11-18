import 'package:todo_clear/db/db_consts.dart';

class Task {
  int id = 0;
  String title = '';
  int isDone = 0;
  int colId = 0;

  Task({required this.id, required this.colId, required this.title, this.isDone = 0});

  void toggleIsDone() {
    isDone == 0 ? 1 : 0;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[dTaskId] = id;
    map[dCollectionId] = colId;
    map[dTaskTitle] = title;
    map[dTaskIsDone] = isDone;
    return map;
  }

  // Extract a Note object from a Map object
  Task.fromMapObject(Map<String, dynamic> map) {
    id = map[dTaskId];
    colId = map[dCollectionId];
    title = map[dTaskTitle];
    isDone = map[dTaskIsDone];
  }
}
