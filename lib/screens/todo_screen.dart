import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../boxes.dart';
import '../models/todo.dart';
import '../widget/todo_dialog.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/logo.png', fit: BoxFit.cover),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Todo>>(
          valueListenable: Boxes.getTodo().listenable(),
          builder: (context, box, _) {
            final todos = box.values.toList().cast<Todo>();
            return buildContent(todos);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => TodoDialog(
              onClickedDone: addTodo,
            ),
          ),
        ),
      );

  Widget buildContent(List<Todo> todos) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Expanded(
          flex: 1,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return buildTodo(context, todo);
            },
          ),
        ),
      ],
    );
  }
}

Widget buildTodo(
  BuildContext context,
  Todo todo,
) {
  return Card(
    color: Colors.white,
    child: ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      title: Text(
        todo.id,
        maxLines: 3,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        todo.description,
        maxLines: 5,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
      ),
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 128,
          maxWidth: 128,
          minHeight: 64,
          minWidth: 64,
        ),
        child: Image.network(todo.imgurl),
      ),
      children: [
        buildButtons(context, todo),
      ],
    ),
  );
}

Widget buildButtons(BuildContext context, Todo todo) => Row(
      children: [
        Expanded(
          child: TextButton.icon(
            label: const Text('Delete'),
            icon: const Icon(Icons.delete),
            onPressed: () => deleteTodo(todo),
          ),
        )
      ],
    );

Future addTodo(String _id, String _description, String _imgurl) async {
  final todo = Todo()
    ..id = _id
    ..description = _description
    ..imgurl = _imgurl;

  final box = Boxes.getTodo();
  box.add(todo);
}

void deleteTodo(Todo todo) {
  // final box = Boxes.getTodos();
  // box.delete(todo.key);

  todo.delete();
  //setState(() => todos.remove(todo));
}
