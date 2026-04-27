import 'package:task_manager/models/task.dart';
import 'package:flutter/foundation.dart';

class TaskViewModel extends ChangeNotifier {
  TaskViewModel();

  final _taskMap = <int, Task>{};
  int _nextId = 0;

  void toggleDone(int taskId) {
    if (!_taskMap.containsKey(taskId)) return;
    _taskMap[taskId] = _taskMap[taskId]!.toggleDone();
    notifyListeners();
  }

  void deleteTask(int taskId) {
    if (!_taskMap.containsKey(taskId)) return;
    _taskMap.remove(taskId);
    notifyListeners();
  }

  void addTask(String title) {
    final Task task = Task(id: _nextId++, title: title, done: false);
    _taskMap[task.id] = task;
    notifyListeners();
  }

  List<Task> get tasks => List.unmodifiable(_taskMap.values);
}
