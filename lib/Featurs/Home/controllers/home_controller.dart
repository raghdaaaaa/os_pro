import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brain_stack/models/task_model.dart';
import 'package:brain_stack/services/task_service.dart';

// ──────────────────────────────────────────────────────────
// WHAT THIS CONTROLLER DOES (for teammates):
//
//  • tasksStream              → live list of ALL user tasks (use with StreamBuilder)
//  • todayTasks(list)         → filters to only today's tasks
//  • completionRate(list)     → 0.0–1.0 for the progress bar (e.g. 0.7 = 70%)
//  • completedCount(list)     → number of finished tasks today
//  • completeTask(taskId)     → marks a task as done
//  • deleteTask(taskId)       → removes a task
// ──────────────────────────────────────────────────────────

class HomeController extends ChangeNotifier {
  final _taskService = TaskService();
  final _auth        = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';
  String get username {
    final email = _auth.currentUser?.email ?? '';
    // Extract username part before the @
    return email.split('@').first.replaceAll('_', ' ');
  }

  // Live stream — wrap this with StreamBuilder in home_screen.dart
  Stream<List<TaskModel>> get tasksStream => _taskService.getTasks(userId);

  // Only today's tasks
  List<TaskModel> todayTasks(List<TaskModel> all) {
    final now = DateTime.now();
    return all.where((t) =>
      t.dueDate.year  == now.year  &&
      t.dueDate.month == now.month &&
      t.dueDate.day   == now.day
    ).toList();
  }

  // 0.0 to 1.0 — used for the progress bar widget
  double completionRate(List<TaskModel> tasks) {
    if (tasks.isEmpty) return 0.0;
    return tasks.where((t) => t.isCompleted).length / tasks.length;
  }

  // How many tasks are done
  int completedCount(List<TaskModel> tasks) =>
      tasks.where((t) => t.isCompleted).length;

  Future<void> completeTask(String taskId) => _taskService.completeTask(taskId);
  Future<void> deleteTask(String taskId)   => _taskService.deleteTask(taskId);
}
