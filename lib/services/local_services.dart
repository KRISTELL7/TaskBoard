import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taskboard/models/task.dart' as Task show Task;

class LocalServices {
  static const String userKey = "task";
  Future<void> saveTasks(List<Task.Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = tasks
        .map((task) => jsonEncode(task.toJson()))
        .toList();
    await prefs.setStringList(userKey, jsonList);
  }

  Future<List<Task.Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(userKey) ?? [];

    return data.map((e) => Task.Task.fromJson(jsonDecode(e))).toList();
  }
}
