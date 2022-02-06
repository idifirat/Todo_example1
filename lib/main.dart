import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../screens/todo_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todo');

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: TodoScreen(),
      );
}
