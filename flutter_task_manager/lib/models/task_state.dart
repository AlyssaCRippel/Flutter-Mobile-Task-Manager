import '../models/task_model.dart';

class TaskState {
  final List<Task> tasks;

  TaskState({required this.tasks});

  /// Create a new state with updated values
  TaskState copyWith({List<Task>? tasks}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }

  /// Convert state to JSON (for HydratedCubit storage)
  Map<String, dynamic> toJson() {
    return {
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  /// Create state from JSON (for HydratedCubit restore)
  factory TaskState.fromJson(Map<String, dynamic> json) {
    final taskList = (json['tasks'] as List)
        .map((item) => Task.fromJson(item))
        .toList();

    return TaskState(tasks: taskList);
  }
}
