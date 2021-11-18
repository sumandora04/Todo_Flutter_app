import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_clear/constant.dart';
import 'package:todo_clear/model/task.dart';
import 'package:todo_clear/model/task_collection.dart';
import 'package:todo_clear/providers/collection_provider.dart';
import 'package:todo_clear/providers/task_provider.dart';
import 'package:todo_clear/util.dart';

class AddTaskScreen extends StatelessWidget {
  final TodoScreen whichScreen;
  late int colId;
  AddTaskScreen({required this.whichScreen, required this.colId});
  AddTaskScreen.secondary({required this.whichScreen});

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Container(
      color: kInactiveCardColor,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: kActiveCardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
        whichScreen == TodoScreen.taskList
            ? 'Add Task'
            : 'Add Collection',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.red,
              ),
            ),
            TextField(
              style: kPrimaryTextStyle,
              decoration: InputDecoration(
                hintText:  whichScreen == TodoScreen.taskList
                    ? 'Add Task'
                    : 'Add Collection',
                // filled: true,
                border: InputBorder.none,
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
              onSubmitted: (value) {
                saveTask(context, value);
              },
            ),
            MaterialButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.red,
              onPressed: () {
                saveTask(context, newTaskTitle);
              },
            ),
          ],
        ),
      ),
    );
  }

  void saveTask(BuildContext context, String title) {
    if (title.isNotEmpty) {
      if (whichScreen == TodoScreen.collection) {
        final p = Provider.of<CollectionProvider>(context, listen: false);
        TaskCollection coll = TaskCollection(id: DateTime.now().microsecondsSinceEpoch, collectionTitle: title);
        p.insertOrUpdateCollection(coll, EditMode.ADD);
      } else if (whichScreen == TodoScreen.taskList) {
        final p = Provider.of<TaskProvider>(context, listen: false);
        Task task = Task(colId: colId,
            id: DateTime.now().microsecondsSinceEpoch, title: title, isDone: 0);
        p.insertOrUpdateTask(task, EditMode.ADD);
      }
      Navigator.pop(context);
    }
  }
}
