import '../models/task_model.dart';

class TaskState {
  final List<Task> tasks;
  final bool isLoading;
  final String? errorMessage;

  TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  /// Creates a copy of the current TaskState with the given parameters.
  /// @param tasks The new list of tasks.
  /// @param errorMessage The new error message for the task state.
  TaskState copyWith({List<Task>? tasks, bool? isLoading, String? errorMessage}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}