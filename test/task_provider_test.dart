import 'package:flutter_test/flutter_test.dart';
import 'package:taskboard/models/task.dart';
import 'package:taskboard/providers/task_provider.dart';
import 'package:flutter/widgets.dart';

void main() {
  test('Agregar y eliminar tarea', () {
    WidgetsFlutterBinding.ensureInitialized();
    final provider = TaskProvider();

    final task = Task(id: '1', title: 'Prueba', description: 'Test');
    provider.addTask(task);

    expect(provider.tasks.length, 1);
    expect(provider.tasks[0].title, 'Prueba');

    provider.tasks[0].isCompleted = true;
    provider.deleteCompleted(provider.tasks[0].id);

    expect(provider.tasks.length, 0); 
  });
}
