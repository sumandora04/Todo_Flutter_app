import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_clear/color_pellette.dart';
import 'package:todo_clear/model/task.dart';
import 'package:todo_clear/providers/task_provider.dart';
import 'package:todo_clear/screens/task_add.dart';
import 'package:todo_clear/util.dart';
import 'package:todo_clear/widgets/no_task_ui.dart';
import 'package:todo_clear/widgets/swipe_dismiss.dart';
import 'package:todo_clear/widgets/task_tile.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({Key? key}) : super(key: key);
  static const route = '/task_list_screen';
  late int _collectionId;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String appBarTitle = args['title'];
    _collectionId = args['collectionId'];
    final provider = Provider.of<TaskProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0A0E21),
          elevation: 0,
          title: Text(appBarTitle.toUpperCase()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: FutureBuilder<List<Task>>(
          future: provider.getTasks(_collectionId),
          builder: (context, snapshot) {
            // return taskListWidget(context, provider);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return NoTaskUI(
                whichScreen: TodoScreen.taskList,
                colId: _collectionId,
              );
            } else {
              return showTaskListScreen(context);
            }
          },
        ),
      ),
    );
  }

  Widget showTaskListScreen(BuildContext context) {
    return Consumer<TaskProvider>(
        child: NoTaskUI(
          whichScreen: TodoScreen.taskList,
          colId: _collectionId,
        ),
        builder: (context, taskProvider, child) {
          if (taskProvider.taskCount == 0) {
            return child!;
          } else {
            return taskListWidget(context, taskProvider);
          }
        });
  }

  Widget taskListWidget(BuildContext context, TaskProvider taskProvider) {
    return ListView.builder(
      itemCount: taskProvider.taskCount,
      // onReorder: (int oldIndex, int newIndex) {
      //   taskProvider.reOrderTask(oldIndex, newIndex);
      // },
      itemBuilder: (BuildContext context, int index) {
        final task = taskProvider.tasks[index];
        return Dismissible(
          onDismissed: (direction) =>
              dismissItem(taskProvider, task, direction),
          key: ObjectKey(task),
          background: SwipeDismiss(direction: SwipeDirection.right),
          secondaryBackground: SwipeDismiss(direction: SwipeDirection.left),
          child: TaskTile(
            taskName: task.title,
            isComplete: task.isDone,
            color: index <= 10
                ? kStyleColorPalette[index]!
                : kStyleColorPalette[10]!,
          ),
        );
      },
    );
  }

  void dismissItem(
      TaskProvider taskProvider, Task task, DismissDirection direction) {
    switch (direction) {
      case DismissDirection.startToEnd:
        // taskProvider.checkOfTask(task);
        taskProvider.insertOrUpdateTask(task, EditMode.UPDATE);
        break;

      case DismissDirection.endToStart:
        taskProvider.deleteTask(task);
        break;

      default:
        break;
    }
  }

  showAddTaskDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskScreen(
                whichScreen: TodoScreen.taskList,
                colId: _collectionId,
              ),
            )));
  }
}
