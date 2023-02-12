import 'package:flutter/material.dart';
import '../models/task.dart';

class CompletedTasks with ChangeNotifier {
  final List<Task> _completedTasks = [];

  List get completedTasks => _completedTasks;

  void deleteTask(int index) {
    _completedTasks.remove(completedTasks[index]);
    notifyListeners();
  }

  void addTask(Task task) {
    _completedTasks.add(task);
    notifyListeners();
  }
}
