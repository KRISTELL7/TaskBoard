import 'package:flutter/material.dart';
import 'package:taskboard/models/task.dart';
import 'package:taskboard/services/api_services.dart';
import 'package:taskboard/services/local_services.dart';

class TaskProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  final LocalServices storage = LocalServices();
  List<Task> tasks = [];
  String filter = "all";
  String search = "";
  Future<void> loadTasks() async {
    tasks = await storage.loadTasks();
    notifyListeners();
  }

  List<Task> get filteredTasks {
    List<Task> filtered = tasks;
    if (filter == "completed") {
      filtered = filtered.where((t) => t.isCompleted).toList();
    } else if (filter == "pending") {
      filtered = filtered.where((t) => !t.isCompleted).toList();
    }

    if (search.isNotEmpty) {
      filtered = filtered
          .where((t) => t.title.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    return filtered;
  }

  Future<void> addTask(Task task) async {
    try {
      tasks.add(task);
      
      await storage.saveTasks(tasks);
      
      notifyListeners();
    } catch (e) {
      print("Error al guardar: $e");
    }
  }

  Future<void> deleteCompleted(String id) async {
    tasks.removeWhere((t) => t.id == id);
    await storage.saveTasks(tasks);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await api.updateTask(task);
    int index = tasks.indexWhere((t) => t.id == task.id);
    tasks[index] = task;
    await storage.saveTasks(tasks);
    notifyListeners();
  }

  void toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }

  void setFilter(String value) {
    filter = value;
    notifyListeners();
  }

  void setSearch(String value) {
    search = value;
    notifyListeners();
  }

  void deleteTask(String id) {}
}
