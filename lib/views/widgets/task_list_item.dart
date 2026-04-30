import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.isDone,
    required this.title,
    required this.toggleDone,
    required this.delete,
  });
  final bool isDone;
  final String title;
  final void Function() toggleDone;
  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: IconButton(
        onPressed: toggleDone,
        icon: Icon(
          isDone
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
        ),
      ),
      trailing: IconButton(
        onPressed: delete,
        icon: Icon(Icons.delete_forever_outlined),
      ),
    );
  }
}
