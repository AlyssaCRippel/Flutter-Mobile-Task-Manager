class Task {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
  });

  /// Creates a copy of the current Task with the given parameters.
  /// @param id The new ID for the task.
  /// @param title The new title for the task.
  /// @param description The new description for the task.
  /// @param isDone The new completion status for the task.
  Task copyWith({String? id, String? title, String? description, bool? isDone,}) 
  {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}