import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late String imgurl;

}