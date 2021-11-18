import 'package:flutter/material.dart';
import 'package:todo_clear/constant.dart';
import 'package:todo_clear/screens/task_add.dart';
import 'package:todo_clear/util.dart';

class NoTaskUI extends StatelessWidget {
  final TodoScreen whichScreen;
  late int colId;
  NoTaskUI({required this.whichScreen, required this.colId});
  NoTaskUI.secondary({required this.whichScreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              whichScreen == TodoScreen.taskList
              ? 'No task yet.Click the button below to add one.'
              : 'No collection yet.Click the button below to add one.',
              style: kPrimaryTextStyle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  showAddTaskDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child:  whichScreen == TodoScreen.taskList
                  ? AddTaskScreen(whichScreen: whichScreen,colId: colId,)
                  : AddTaskScreen.secondary(whichScreen: whichScreen),
            )));
  }
}
