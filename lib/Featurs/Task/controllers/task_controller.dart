import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brain_stack/models/task_model.dart';
import 'package:brain_stack/services/task_service.dart';

// ──────────────────────────────────────────────────────────
// WHAT THIS CONTROLLER DOES (for teammates):
//
//  • title, description, priority, dueDate, startTime, endTime
//                             → bind these to the form fields
//  • setPriority(value)       → call when user picks High/Medium/Low
//  • setDueDate(date)         → call when user picks a date
//  • saveTask()               → saves NEW task to Firestore
//  • updateTask(taskId)       → saves EDITS to existing task
//  • loadTask(task)           → pre-fills form when editing
//  • isLoading                → show spinner on Save button
//  • errorMessage             → show in red if something fails
//  • isSuccess                → true when saved (navigate back)
// ──────────────────────────────────────────────────────────

class TaskController extends ChangeNotifier {
  final _taskService = TaskService();
  final _auth        = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  // Form field values — teammates bind TextControllers to these
  String title       = '';
  String description = '';
  String priority    = 'medium';
  DateTime dueDate   = DateTime.now();
  String startTime   = '';
  String endTime     = '';

  bool    isLoading    = false;
  bool    isSuccess    = false;
  String? errorMessage;

  // Pre-fill the form when user opens Edit Task screen
  void loadTask(TaskModel task) {
    title       = task.title;
    description = task.description;
    priority    = task.priority;
    dueDate     = task.dueDate;
    startTime   = task.startTime;
    endTime     = task.endTime;
    notifyListeners();
  }

  void setPriority(String value) { priority = value; notifyListeners(); }
  void setDueDate(DateTime d)    { dueDate  = d;     notifyListeners(); }

  // Save a new task
  Future<void> saveTask() async {
    if (title.trim().isEmpty) {
      errorMessage = 'Please enter a task title.';
      notifyListeners();
      return;
    }
    _start();
    try {
      await _taskService.addTask(TaskModel(
        userId:      userId,
        title:       title.trim(),
        description: description.trim(),
        priority:    priority,
        dueDate:     dueDate,
        startTime:   startTime,
        endTime:     endTime,
        points:      _points(),
      ));
      isSuccess = true;
    } catch (_) {
      errorMessage = 'Could not save task. Try again.';
    }
    _done();
  }

  // Update an existing task
  Future<void> updateTask(String taskId) async {
    if (title.trim().isEmpty) {
      errorMessage = 'Please enter a task title.';
      notifyListeners();
      return;
    }
    _start();
    try {
      await _taskService.updateTask(taskId, {
        'title':       title.trim(),
        'description': description.trim(),
        'priority':    priority,
        'dueDate':     dueDate,
        'startTime':   startTime,
        'endTime':     endTime,
        'points':      _points(),
      });
      isSuccess = true;
    } catch (_) {
      errorMessage = 'Could not update task. Try again.';
    }
    _done();
  }

  // High priority = more points
  int _points() {
    if (priority == 'high')   return 30;
    if (priority == 'medium') return 20;
    return 10;
  }

  void _start() {
    isLoading = true; isSuccess = false; errorMessage = null;
    notifyListeners();
  }

  void _done() { isLoading = false; notifyListeners(); }
}
