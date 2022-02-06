import 'package:hive/hive.dart';
import 'package:squamobi_interview/models/todo.dart';

class Boxes{
  static Box<Todo> getTodo() =>
  Hive.box<Todo>('todo');
}