import 'package:task_manager/models/task.dart';
import 'package:flutter/foundation.dart';

class TaskViewModel extends ChangeNotifier {
  TaskViewModel();

  final _taskList = <Task>[];
  int _nextId = 0;

  void toggleDone(int taskIndex) {
    if (_isIndexInvalid(taskIndex)) {
      return;
    }
    _taskList[taskIndex] = _taskList[taskIndex].toggleDone();
    notifyListeners();
  }

  void deleteTask(int taskIndex) {
    if (_isIndexInvalid(taskIndex)) {
      return;
    }
    _taskList.removeAt(taskIndex);
    notifyListeners();
  }

  void addTask(String title) {
    final Task task = Task(id: _nextId++, title: title, done: false);
    _taskList.add(task);
    notifyListeners();
  }

  bool _isIndexInvalid(int taskIndex) =>
      taskIndex < 0 || taskIndex >= _taskList.length;

  List<Task> get tasks => List.unmodifiable(_taskList);
}
