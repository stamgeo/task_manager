import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/viewmodels/task_viewmodel.dart';
import 'package:task_manager/views/widgets/task_list_item.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) => ListView.builder(
        itemBuilder: (context, index) {
          Task task = taskViewModel.tasks[index];

          return TaskListItem(
            key: ValueKey(task.id),
            isDone: task.done,
            title: task.title,
            toggleDone: () => taskViewModel.toggleDone(index),
            delete: () => taskViewModel.deleteTask(index),
          );
        },
        itemCount: taskViewModel.tasks.length,
      ),
    );
  }
}
