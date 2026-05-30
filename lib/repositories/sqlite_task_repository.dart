import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/repositories/task_repository.dart';

class SqliteTaskRepository extends TaskRepository {
  final _SQLiteDatabaseHelper _databaseHelper = _SQLiteDatabaseHelper();

  @override
  Future<void> deleteTask(Task task) async {
    Database db = await _databaseHelper.getDatabase();
    await db.delete(
      _SQLiteDatabaseHelper._taskTableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<List<Task>> getTasks() async {
    Database db = await _databaseHelper.getDatabase();
    List<Map<String, Object?>> results = await db.query(
      _SQLiteDatabaseHelper._taskTableName,
    );
    return results.map((result) => Task.fromMap(result)).toList();
  }

  @override
  Future<void> saveTask(Task task) async {
    Database db = await _databaseHelper.getDatabase();
    await db.insert(_SQLiteDatabaseHelper._taskTableName, task.toMap());
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    Database db = await _databaseHelper.getDatabase();
    Batch batch = db.batch();
    for (final task in tasks) {
      batch.insert(_SQLiteDatabaseHelper._taskTableName, task.toMap());
    }
    await batch.commit();
  }

  @override
  Future<void> updateTask(Task task) async {
    Database db = await _databaseHelper.getDatabase();
    await db.update(
      _SQLiteDatabaseHelper._taskTableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}

class _SQLiteDatabaseHelper {
  static const String _taskTableName = 'Task';

  static final String createTaskTableQuery =
      'CREATE TABLE $_taskTableName (id INTEGER PRIMARY KEY, title TEXT, done INTEGER)';

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(createTaskTableQuery);
  }

  Future<Database> _init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    return await openDatabase(path, onCreate: _onCreate);
  }

  static const String _dbName = 'task_db.db';
  Database? _db;

  Future<Database> getDatabase() async {
    _db ??= await _init();
    return _db!;
  }
}
