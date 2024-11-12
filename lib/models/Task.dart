class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime dateTime;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.dateTime,
  });

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
