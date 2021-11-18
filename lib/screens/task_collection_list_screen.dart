import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_clear/color_pellette.dart';
import 'package:todo_clear/model/task_collection.dart';
import 'package:todo_clear/providers/collection_provider.dart';
import 'package:todo_clear/screens/task_add.dart';
import 'package:todo_clear/util.dart';
import 'package:todo_clear/widgets/collection_list_tiles.dart';
import 'package:todo_clear/widgets/no_task_ui.dart';
import 'package:todo_clear/widgets/swipe_dismiss.dart';

class TaskCollectionListScreen extends StatefulWidget {
  const TaskCollectionListScreen({Key? key}) : super(key: key);
  static const route = '/task_collection-list-screen';

  @override
  State<TaskCollectionListScreen> createState() =>
      _TaskCollectionListScreenState();
}

class _TaskCollectionListScreenState extends State<TaskCollectionListScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollectionProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0E21),
        elevation: 0,
        title: Text('TODO'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskDialog(context);
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: FutureBuilder<List<TaskCollection>>(
          future: provider.getCollection(),
          builder: (context, snapshot) {
            return buildConsumerCollection(context);
          }),
    );
  }

  Consumer<CollectionProvider> buildConsumerCollection(BuildContext context) {
    return Consumer<CollectionProvider>(
      child: NoTaskUI.secondary(whichScreen: TodoScreen.collection),
      builder: (BuildContext context, collProv, Widget? child) {
        if (collProv.collectionCount == 0) {
          return child!;
        } else {
          // return collectionList(collProv);
          return ListView.builder(
            itemCount: collProv.collectionCount,
            itemBuilder: (BuildContext context, int index) {
              final coll = collProv.taskCollection[index];
              return Dismissible(
                onDismissed: (direction) =>
                    dismissItem(collProv, coll, direction),
                key: ObjectKey(coll),
                direction: DismissDirection.endToStart,
                background: SwipeDismiss(
                  direction: SwipeDirection.left,
                ),
                // secondaryBackground: swipeLeft(),
                child: CollectionListTile(
                  title: coll.collectionTitle,
                  taskCount: 0,
                  color: index <= 15
                      ? kStyleColorPalette[index]!
                      : kStyleColorPalette[15]!,
                  colId: coll.id,
                ),
              );
            },
          );
        }
      },
    );
  }

  void dismissItem(CollectionProvider collectionProvider, TaskCollection coll,
      DismissDirection direction) {
    switch (direction) {
      case DismissDirection.endToStart:
        collectionProvider.deleteCollection(coll);
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
              child: AddTaskScreen.secondary(
                whichScreen: TodoScreen.collection,
              ),
            )));
  }
}
