import 'package:flutter/material.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({super.key, required this.addTaskCallback, required this.isTitleInvalidCallback});

  final void Function(String taskTitle) addTaskCallback;
  final bool Function(String taskTitle) isTitleInvalidCallback;

  @override
  State<StatefulWidget> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final _controller = TextEditingController();

  void _addTask() {
    if (widget.isTitleInvalidCallback(_controller.text)) {
      return;
    }
    widget.addTaskCallback(_controller.text);
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextField(controller: _controller, decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          hintText: 'type task here',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              style: BorderStyle.solid,          
            ),
          ),
        ),)),
        TextButton(onPressed: _addTask, child: const Text('Add task')),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
