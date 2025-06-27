import '../models/task_model.dart';

/// An abstract class that defines the methods for a task repository.
abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> toggleTaskCompletion(String id);
}
