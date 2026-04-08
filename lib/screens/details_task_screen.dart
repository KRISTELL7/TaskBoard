import 'package:flutter/material.dart';
import '../models/task.dart';

class DetailsTaskScreen extends StatelessWidget {
  final Task task;

  const DetailsTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle de tarea")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    task.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    task.description.isEmpty
                        ? "Sin descripción"
                        : task.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    task.isCompleted ? "✔ Completada" : "⏳ Pendiente",
                    style: TextStyle(
                      fontSize: 16,
                      color: task.isCompleted ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
