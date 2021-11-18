import 'package:flutter/material.dart';

enum SwipeDirection { left, right }

class SwipeDismiss extends StatelessWidget {
  SwipeDismiss({required this.direction});

  final SwipeDirection direction;

  @override
  Widget build(BuildContext context) {
    return direction == SwipeDirection.right
        ? Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            color: Colors.green,
          )
        : Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: 40,
              ),
            ),
            color: Colors.black,
          );
  }
}
