import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../models/task_model.dart';
import '../models/task_state.dart';

/// Cubit to manage task state
/// This class extends HydratedCubit to persist state across app restarts
/// 
class TaskCubit extends HydratedCubit<TaskState> { //hydtratedCubit is used to persist state to local disk

  /// Constructor initializes the state with an empty task list
  TaskCubit() : super(TaskState(tasks: []));

  // Add a new task
  void addTask(Task task) {
    // Create a copy of the current tasks
    final updatedTasks = List<Task>.from(state.tasks);
    //add the new task to the list
    updatedTasks.add(task);
    // Emit the new state with the updated task list
    emit(state.copyWith(tasks: updatedTasks));
  }

  //toggle task completion status
  void toggleTask(String taskId) {
    final updatedTasks = state.tasks.map((task) {
      // If the task ID matches, toggle its isDone status
      if (task.id == taskId) {
        return task.copyWith(isDone: !task.isDone);
      }
      // Otherwise, return the task unchanged
      return task;
    }).toList();
    // Emit the new state with the updated task list
    emit(state.copyWith(tasks: updatedTasks));
  }

  //remove a task by Id
  void removeTask(String taskId){
    // keep all tasks in the list except the one with the given ID
    final updatedTasks = state.tasks.where((task) => task.id != taskId).toList();
    // Emit the new state with the updated task list
    emit(state.copyWith(tasks: updatedTasks));
  }

  /// Loads state from disk
  @override
  TaskState fromJson(Map<String, dynamic> json) {
    return TaskState.fromJson(json);
  }

  /// Saves state to disk
  @override
  Map<String, dynamic> toJson(TaskState state) {
    return state.toJson();
  }

}