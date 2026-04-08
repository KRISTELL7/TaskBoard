import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/task.dart';
import 'package:taskboard/providers/task_provider.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      title = widget.task!.title;
      description = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "agregar tarea" : "editar tarea"),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: "Titulo"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "campo requerido";
                  }
                  return null;
                },
                onSaved: (value) => title = value ?? "",
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: "Descripción"),

                onSaved: (value) => description = value ?? "",
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.task == null) {
                      provider.addTask(
                        Task(
                          id: Uuid().v4(),
                          title: title,
                          description: description,
                        ),
                      );
                    } else {
                      widget.task!.title = title;
                      widget.task!.description = description;
                      provider.updateTask(widget.task!);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.task == null ? "guardar" : "actualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
