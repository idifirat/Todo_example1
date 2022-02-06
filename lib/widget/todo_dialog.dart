import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoDialog extends StatefulWidget {
  final Todo? todo;
  final Function(String id, String description, String imgurl) onClickedDone;

  const TodoDialog({
    Key? key,
    this.todo,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final descriptionController = TextEditingController();
  final imgurlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      final todo = widget.todo!;

      idController.text = todo.id;
      descriptionController.text = todo.description;
      //imgurl = todo.imgurl;
    }
  }

  @override
  void dispose() {
    idController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const title = 'Add Todo';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 8),
              buildImgurl(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: idController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Title',
        ),
        validator: (id) =>
            id != null && id.isEmpty ? 'Title' : null,
      );

  Widget buildDescription() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Description',
        ),
        validator: (description) =>
            description != null && description.isEmpty ? 'Description' : null,
        controller: descriptionController,
      );
  Widget buildImgurl() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Image Url',
        ),
        keyboardType: TextInputType.number,
        validator: (imgurl) =>
            imgurl != null && imgurl.isEmpty ? 'Image Url' : null,
        controller: imgurlController,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context) {
    return TextButton(
      child: const Text("Add"),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final id = idController.text;
          final description = descriptionController.text;
          final imgurl = imgurlController.text;

          widget.onClickedDone(id, description, imgurl);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
