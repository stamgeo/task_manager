import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/viewmodels/task_viewmodel.dart';
import 'package:task_manager/views/screens/task_screen.dart';
import 'package:task_manager/views/widgets/add_task_bar.dart';

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
      home: Scaffold(
        body: const TaskScreen(),
        bottomNavigationBar: AddTaskBar(
          addTaskCallback: (String taskTitle) {
            
            context.read<TaskViewModel>().addTask(taskTitle);
          },
        ),
      ),
    );
  }
}
