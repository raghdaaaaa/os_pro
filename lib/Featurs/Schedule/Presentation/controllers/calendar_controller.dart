import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brain_stack/models/task_model.dart';
import 'package:brain_stack/services/task_service.dart';

// ──────────────────────────────────────────────────────────
// WHAT THIS CONTROLLER DOES (for teammates):
//
//  • allTasksStream           → live stream of every task (StreamBuilder)
//  • selectedDate             → the day currently tapped on calendar
//  • selectDate(date)         → call when user taps a calendar day
//  • tasksForDate(list, date) → filters list to only that day's tasks
//  • datesWithTasks(list)     → set of dates that have tasks (mark with dot)
// ──────────────────────────────────────────────────────────

class CalendarController extends ChangeNotifier {
  final _taskService = TaskService();
  final _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  DateTime selectedDate = DateTime.now();

  CalendarController() {
    final now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  // Full task stream — filter it using tasksForDate()
  Stream<List<TaskModel>> get allTasksStream => _taskService.getTasks(userId);

  // Call this when user taps a day on the calendar
  void selectDate(DateTime date) {
    selectedDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  // Returns only tasks that match the given date
  List<TaskModel> tasksForDate(List<TaskModel> all, DateTime date) {
    return all
        .where((t) =>
            t.dueDate.year == date.year &&
            t.dueDate.month == date.month &&
            t.dueDate.day == date.day)
        .toList();
  }

  // Returns set of dates that have at least one task → put a dot on calendar
  Set<DateTime> datesWithTasks(List<TaskModel> all) {
    return all
        .map((t) => DateTime(t.dueDate.year, t.dueDate.month, t.dueDate.day))
        .toSet();
  }
}
