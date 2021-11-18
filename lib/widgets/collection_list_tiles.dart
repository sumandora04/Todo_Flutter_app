import 'package:flutter/material.dart';
import 'package:todo_clear/constant.dart';
import 'package:todo_clear/screens/task_list_screen.dart';

class CollectionListTile extends StatelessWidget {
  CollectionListTile(
      {required this.title,
      required this.taskCount,
      required this.color,
      required this.colId});

  final String title;
  final int taskCount;
  final Color color;
  final int colId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5,
      ),
      child: Material(
        color: color,
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          dense: false,
          onTap: () {
            Navigator.of(context).pushNamed(TaskListScreen.route,
                arguments: {'title': title, 'collectionId': colId});
          },
          title: Text(
            title,
            style: kPrimaryTextStyle,
          ),
        ),
      ),
    );
  }
}
