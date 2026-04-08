import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/providers/task_provider.dart';
import 'package:taskboard/screens/add_task_screen.dart';
import 'package:taskboard/widgets/task_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("TaskBoard📝")),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Buscar tareas...",
                border: OutlineInputBorder(),
              ),
              onChanged: provider.setSearch,
            ),
          ),
          // Filtros
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => provider.setFilter("all"),
                child: const Text("Todas📋"),
              ),
              TextButton(
                onPressed: () => provider.setFilter("pending"),
                style: TextButton.styleFrom(
                  backgroundColor: provider.filter == "pending"
                      ? Colors.greenAccent
                      : Colors.grey[200],
                ),
                child: const Text("Pendientes📌"),
              ),
              TextButton(
                onPressed: () => provider.setFilter("completed"),
                style: TextButton.styleFrom(
                  backgroundColor: provider.filter == "completed"
                      ? Colors.greenAccent
                      : Colors.grey[200],
                ),
                child: const Text("Completadas✅"),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Lista de tareas
          Expanded(
            child: ListView.builder(
              itemCount: provider.filteredTasks.length,
              itemBuilder: (context, index) {
                final task = provider.filteredTasks[index];

                return TaskItem(
                  task: task,
                  // El callback de eliminar ahora llama directamente al provider
                  onDelete: task.isCompleted
                      ? () {
                          provider.deleteTask(task.id); // Borra la tarea
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
      // Botón agregar solo si filtro == "all"
      floatingActionButton: provider.filter == "all"
          ? FloatingActionButton(
              onPressed: () async {
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddTaskScreen()),
                );

                if (newTask != null) {
                  provider.addTask(newTask); // Agrega tarea nueva
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
