
import 'package:taskboard/models/task.dart';


class ApiServices {
  List<Task> _tasks = [];

  Future<List<Task>> getTasks() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _tasks;
  }

  Future<void> addTask(Task task) async {
    await Future.delayed(Duration(milliseconds: 400));
    return _tasks.add(task);
  }

  Future<void> updateTask(Task task) async {
    await Future.delayed(Duration(milliseconds: 400));
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _tasks[index] = task;
  }

  Future<void> deleteTask(String id) async {
    await Future.delayed(Duration(milliseconds: 300));
    _tasks.removeWhere((t) => t.id == id);
  }
}
