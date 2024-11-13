import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../models/Task.dart';

class TaskProvider with ChangeNotifier {
  final LocalStorage storage;

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider({required this.storage}) {
    loadTasks(); // Load tasks from local storage on initialization
  }

  // Load tasks from local storage
  Future<void> loadTasks() async {
    storage.removeItem('tasks');
    var storedData = storage.getItem('tasks');
    print('storedData');
    print(storedData);
    if (storedData != null) {
      List jsonData = jsonDecode(storedData);
      _tasks = List<Task>.from(
        jsonData.map((item) => Task.fromJson(item)),
      );
    }
  }

  void saveTasks() {
    print('taskkkkkkkk');
    print(_tasks);
    List<Map<String, dynamic>> data = _tasks.map((e) => e.toJson()).toList();
    String jsonString = jsonEncode(data);
    storage.setItem('tasks', jsonString);
  }

  void addTask(Task task) {
    print('tasks');
    print(task.toJson());
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      saveTasks();
      notifyListeners();
    }
  }

  Task? getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id,
        orElse: () => Task(
            id: id,
            title: 'No task',
            status: TaskStatus.todo,
            dateTime: DateTime.now()));
  }
}
