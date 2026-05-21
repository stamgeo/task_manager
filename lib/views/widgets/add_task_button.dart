import 'package:flutter/material.dart';
import 'package:task_manager/views/widgets/add_task_bar.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) =>
            AddTaskBar(onTaskAdded: () => Navigator.pop(context), isAutofocus: true,),
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Icon(Icons.add),
    );
  }
}
