import 'package:task_manager/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> saveTask(Task task);
  Future<void> saveTasks(List<Task> tasks);
  Future<void> deleteTask(Task task);
  Future<void> updateTask(Task task);
}
