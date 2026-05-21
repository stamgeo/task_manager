import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/viewmodels/task_viewmodel.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({super.key});

  @override
  State<StatefulWidget> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              hintText: 'type task here',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            TaskViewModel taskViewModel = context.read<TaskViewModel>();
            if (!taskViewModel.isTaskTitleInvalid(_controller.text)) {
              taskViewModel.addTask(_controller.text);
              _controller.clear();
            }
          },
          child: const Text('Add task'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
