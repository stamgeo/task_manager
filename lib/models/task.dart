import 'package:flutter/material.dart';

@immutable
class Task {
  const Task({required this.id, required this.title, required this.done});

  final int id;
  final String title;
  final bool done;

  Task copyWith({String? title, bool? done}) {
    return Task(id: id, title: title ?? this.title, done: done ?? this.done);
  }

  Task toggleDone() {
    return copyWith(done: !done);
  }

  @override
  bool operator ==(Object other) {
    Task o = other as Task;
    return title == o.title;
  }

  @override
  int get hashCode => title.hashCode;
}
