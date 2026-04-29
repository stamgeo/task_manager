import 'package:flutter/material.dart';


class AddTaskBar extends StatefulWidget {
  const AddTaskBar({super.key, required this.addTaskCallback});

  final void Function(String taskTitle) addTaskCallback;

  @override
  State<StatefulWidget> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final _controller = TextEditingController();

  void _addTask() {
    if (_fieldIsInvalid()) {
      return;
    }
    widget.addTaskCallback(_controller.text);
    _controller.text = '';
  }

  bool _fieldIsInvalid() => _controller.text.isEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextField(controller: _controller),),
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
