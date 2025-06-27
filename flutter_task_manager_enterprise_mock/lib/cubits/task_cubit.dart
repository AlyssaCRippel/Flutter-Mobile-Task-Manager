import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/taskState_model.dart';
import '../Repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskCubit extends Cubit<TaskState> {

  final TaskRepository _repo;

  TaskCubit(this._repo) : super(TaskState());

  Future<void> loadTasks() async {
    emit(state.copyWith(isLoading: true));
    try {
      final tasks = await _repo.getTasks();
      emit(state.copyWith(tasks: tasks as List<Task>?, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> addTask(Task task) async{
    try{
      await _repo.addTask(task);
      await loadTasks(); // Reload tasks after adding
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteTask(String id) async {
    try{
      await _repo.deleteTask(id);
      await loadTasks(); // Reload tasks after deletion
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> toggleTaskCompletion(String id) async {
    try {
      await _repo.toggleTaskCompletion(id);
      await loadTasks(); // Reload tasks after toggling completion
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

 
}

