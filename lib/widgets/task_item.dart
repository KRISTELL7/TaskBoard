import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/task.dart';
import 'package:taskboard/providers/task_provider.dart';
import 'package:taskboard/screens/add_task_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onDelete;

  const TaskItem({super.key, required this.task, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onTap: () {
          // Detalles
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Center(child: Text(task.title)),
              content: Text(
                task.description.isEmpty ? "Sin descripción" : task.description,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar"),
                ),
              ],
            ),
          );
        },
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description.isEmpty ? "Sin descripción" : task.description,
            ),
            Text(
              task.isCompleted ? "Completada" : " Pendiente",
              style: TextStyle(
                color: task.isCompleted ? Colors.green[900] : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Marcar completada
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) => provider.toggleTask(task),
            ),
            // Editar
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskScreen(task: task)),
                );
              },
            ),
            
            if (task.isCompleted)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  provider.deleteCompleted(
                    task.id,
                  ); 
                },
              ),
          ],
        ),
      ),
    );
  }
}
