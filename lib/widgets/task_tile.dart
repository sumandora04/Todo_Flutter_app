import 'package:flutter/material.dart';
import 'package:todo_clear/constant.dart';

class TaskTile extends StatelessWidget {
  final Color color;
  final String taskName;
  final int isComplete;

  TaskTile({
    required this.color,
    required this.taskName,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5,
      ),
      child: Material(
        color: isComplete == 1 ? kActiveCardColor : color,
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          title: Text(
            taskName,
            style: kPrimaryTextStyle.copyWith(
              decoration: isComplete == 1 ? TextDecoration.lineThrough : null,
              decorationThickness: 2,
            ),
          ),
        ),
      ),
    );
  }
}
