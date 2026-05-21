import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/viewmodels/task_viewmodel.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({super.key, this.onTaskAdded, this.isAutofocus = false});

  final void Function()? onTaskAdded;
  final bool isAutofocus;

  @override
  State<StatefulWidget> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final _controller = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            autofocus: widget.isAutofocus,
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
              errorText: errorText,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            TaskViewModel taskViewModel = context.read<TaskViewModel>();
            Set<String>? errorReasons = taskViewModel
                .getReasonsWhyTitleIsInvalid(_controller.text);
            if (errorReasons == null) {
              taskViewModel.addTask(_controller.text);
              _controller.clear();
              widget.onTaskAdded?.call();
            }
            setState(() => errorText = errorReasons?.join('\n'));
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
