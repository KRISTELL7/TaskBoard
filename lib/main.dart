import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/config/theme/app_theme.dart';
import 'package:taskboard/providers/task_provider.dart';
import 'package:taskboard/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TaskBoard",
      theme: AppTheme().getTheme(),
      home: HomeScreen(),
    );
  }
}
