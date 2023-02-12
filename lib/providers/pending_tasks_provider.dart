import 'package:flutter/material.dart';
import '../models/task.dart';

class PendingTasks with ChangeNotifier {
  final List<Task> _pendingTasks = [
    Task(
      title: "Send an email to the team",
      date: DateTime.now(),
      priority: "High",
    ),
    Task(
      title: "Buy tickets to canada",
      date: DateTime.now(),
      priority: "High",
    ),
    Task(
      title: "Talk to steve",
      date: DateTime.now(),
      priority: "High",
    ),
    Task(
      title: "Send an email to the team",
      date: DateTime.now(),
      priority: "High",
    ),
    Task(
      title: "Buy tickets to canada",
      date: DateTime.now(),
      priority: "High",
    ),
    Task(
      title: "Talk to steve",
      date: DateTime.now(),
      priority: "High",
    )
  ];

  List get pendingTasks => _pendingTasks;

  void deleteTask(int index) {
    _pendingTasks.remove(_pendingTasks[index]);
    notifyListeners();
  }

  void addTask(Task task) {
    _pendingTasks.add(task);
    notifyListeners();
  }

  void updateTask(int index, Task task) {
    _pendingTasks[index] = task;
    notifyListeners();
  }
}
