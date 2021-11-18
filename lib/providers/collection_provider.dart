import 'package:flutter/cupertino.dart';
import 'package:todo_clear/db/db_consts.dart';
import 'package:todo_clear/db/db_impl.dart';
import 'package:todo_clear/db/i_collection.dart';
import 'package:todo_clear/model/task_collection.dart';
import 'package:todo_clear/util.dart';

class CollectionProvider with ChangeNotifier {
  ICollection collection = DbImpl();
  List<TaskCollection> _collection = [];

  int get collectionCount {
    return _collection.length;
  }

  List<TaskCollection> get taskCollection {
    return [..._collection];
  }

  Future<List<TaskCollection>> getCollection() async {
    List<Map<String, dynamic>> list =
        await collection.getCollectionListMap();
    _collection =
        list.map((item) => TaskCollection.fromMapObject(item)).toList();
    notifyListeners();
    return taskCollection;
  }

  Future insertOrUpdateCollection(
      TaskCollection coll, EditMode editMode) async {

    if (EditMode.ADD == editMode) {
      _collection.insert(0, coll);
      Future<int> insertCollection = collection.insertCollection(coll);
    }
    notifyListeners();
  }

  Future deleteCollection(TaskCollection coll) {
    _collection.removeWhere((element) => element.id == coll.id);
    notifyListeners();
    // return DatabaseHelper.delete(dTaskTable, collection.id);
    return collection.deleteItem(dCollectionTable, coll.id, dCollectionId);
  }

  void reOrderTask(int oldIndex, int newIndex) {
    final movedTask = _collection.removeAt(oldIndex);

    if (newIndex > oldIndex) {
      // var lastTask = _collection[lastIndex - 1];
      _collection.insert(newIndex - 1, movedTask);
    } else {
      _collection.insert(newIndex, movedTask);
    }
    notifyListeners();
  }
}
