import 'package:todo_clear/db/db_consts.dart';

class TaskCollection {
  int id = 0;
  String collectionTitle = '';

  TaskCollection({
    required this.id,
    required this.collectionTitle,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[dCollectionId] = id;
    map[dCollectionTitle] = collectionTitle;
    return map;
  }

  // Extract a Note object from a Map object
  TaskCollection.fromMapObject(Map<String, dynamic> map) {
    id = map[dCollectionId];
    collectionTitle = map[dCollectionTitle];
  }
}
