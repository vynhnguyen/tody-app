enum TaskStatus { todo, doing, done }

extension TaskStatusExtension on TaskStatus {
  String toShortString() {
    return toString().split('.').last;
  }

  static TaskStatus fromString(String status) {
    return TaskStatus.values.firstWhere(
      (e) => e.toString().split('.').last == status,
      orElse: () => TaskStatus.todo,
    );
  }
}

class Task {
  final String id;
  final String title;
  final String? description;
  final TaskStatus status;
  final DateTime dateTime;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.dateTime,
  });

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: TaskStatusExtension.fromString(json['status'] as String),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.toShortString(),
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
