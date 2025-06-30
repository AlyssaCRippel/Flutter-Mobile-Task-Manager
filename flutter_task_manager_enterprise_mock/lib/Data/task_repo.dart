import '../Repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepo implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  Future<void> addTask(Task task) async {

	 await Future.delayed(Duration(seconds: 2));
    _tasks.add(task);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await Future.delayed(Duration(seconds: 2));
    _tasks.removeWhere((task) => task.id == taskId);
  }

  @override
  Future<List<Task>> getTasks() async {
    await Future.delayed(Duration(seconds: 2));
    return _tasks;
  }

  @override
  Future<void> toggleTaskCompletion(String taskId) async {
    await Future.delayed(Duration(seconds: 2));

    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index == -1) {
      throw Exception("Task not found");
    }

    final oldTask = _tasks[index];
    final updatedTask = oldTask.copyWith(isDone: !oldTask.isDone);

    _tasks[index] = updatedTask;
  }

}