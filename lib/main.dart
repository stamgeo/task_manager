import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/viewmodels/task_viewmodel.dart';
import 'package:task_manager/views/screens/task_screen.dart';
import 'package:task_manager/views/widgets/add_task_button.dart';
import 'package:task_manager/views/widgets/task_progress_indicator.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Task List')),
        body: const TaskScreen(),
        floatingActionButton: AddTaskButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: TaskProgressIndicator(),
      ),
    );
  }
}
