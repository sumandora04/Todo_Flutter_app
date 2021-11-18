import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_clear/db/db_impl.dart';
import 'package:todo_clear/providers/collection_provider.dart';
import 'package:todo_clear/providers/task_provider.dart';
import 'package:todo_clear/screens/task_collection_list_screen.dart';
import 'package:todo_clear/screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbImpl().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CollectionProvider()),
        ChangeNotifierProvider.value(value: TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            platform: TargetPlatform.android,
            primaryColor: Color(0xFF0A0E21),
            scaffoldBackgroundColor: Color(0xFF0A0E21),
            colorScheme:
                ThemeData.dark().colorScheme.copyWith(secondary: Colors.red)),
        home: TaskCollectionListScreen(),
        routes: {
          TaskCollectionListScreen.route: (_ctx) => TaskCollectionListScreen(),
          TaskListScreen.route: (_ctx) => TaskListScreen(),
        },
      ),
    );
  }
}
