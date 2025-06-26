import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../cubits/task_cubit.dart';
import '../models/task_state.dart';
import '../models/task_model.dart';

/// Home screen that displays the task list and allows adding new tasks
/// 
class HomeScreen extends StatelessWidget{

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final taskCubit = context.read<TaskCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return ListTile(
                leading: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    taskCubit.toggleTask(task.id);
                  },
                ),
                title: Text(
                  task.title,
                   style: TextStyle(
                    decoration: task.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: task.description.isNotEmpty
                    ? Text(task.description)
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    taskCubit.removeTask(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog to add new task
          showDialog(
            context: context,
            builder: (context) {
              String title = '';
              String description = '';
              return AlertDialog(
                title: const Text('Add New Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      onChanged: (value) => title = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Description'),
                      onChanged: (value) => description = value,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (title.isNotEmpty) {
                        final newTask = Task(
                          id: const Uuid().v4(),
                          title: title,
                          description: description,
                        );
                        taskCubit.addTask(newTask);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}