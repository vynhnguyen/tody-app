import 'package:json_annotation/json_annotation.dart';

part 'Task.g.dart';

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

@JsonSerializable()
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

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
