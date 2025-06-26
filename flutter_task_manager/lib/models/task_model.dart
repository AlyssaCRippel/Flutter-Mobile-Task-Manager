class Task {
  final String id;
  final String title;
  final String description;
  final bool isDone;

/// Constructor for Task model
  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
  });

// copy task so UI knows when to update, important for cubits
  Task copyWith({
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Task(
      id: id, // ID stays the same
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  // Used by hydrated_bloc to save to disk
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isDone': isDone,
  };

  // Used by hydrated_bloc to restore from disk
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    isDone: json['isDone'],
  );
}
