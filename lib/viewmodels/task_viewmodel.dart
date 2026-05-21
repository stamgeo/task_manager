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
    if (isTaskTitleInvalid(title)) {
      return;
    }
    final Task task = Task(id: _nextId++, title: title, done: false);
    _taskList.add(task);
    notifyListeners();
  }

  Set<String>? getReasonsWhyTitleIsInvalid(String title) {
    Set<String> reasons = {};
    if (title.isEmpty) {
      reasons.add('Task should not be empty');
      return reasons;
    }

    if (_taskList
        .map((Task task) => task.title)
        .any((String existingTitle) => title.trim() == existingTitle.trim())) {
      reasons.add('Task already Exists');
    }

    return reasons.isEmpty ? null : reasons;
  }

  bool isTaskTitleInvalid(String title) =>
      getReasonsWhyTitleIsInvalid(title) != null;

  bool _isIndexInvalid(int taskIndex) =>
      taskIndex < 0 || taskIndex >= _taskList.length;

  List<Task> get tasks => List.unmodifiable(_taskList);

  double get completionPercentage => _taskList.isEmpty
      ? 0
      : tasks.map((Task task) => task.done ? 1 : 0).fold(0, (a, b) => a + b) /
            _taskList.length;
}
