import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brain_stack/services/rewards_service.dart';
import 'package:brain_stack/services/task_service.dart';

// ──────────────────────────────────────────────────────────
// WHAT THIS CONTROLLER DOES (for teammates):
//
//  • setTask(id, title)       → call FIRST before starting timer
//  • start()                  → starts / resumes countdown
//  • pause()                  → pauses timer
//  • reset()                  → resets to 25:00
//  • timeDisplay              → "25:00" string → show in Text widget
//  • progress                 → 1.0 → 0.0 → use in CircularProgressIndicator
//  • isBreak                  → true during 5-min break (change UI color)
//  • isRunning                → true while counting down
//  • sessionsCompleted        → number of full 25-min sessions done
//  Points are awarded automatically — you don't call anything.
// ──────────────────────────────────────────────────────────

class TimerController extends ChangeNotifier {
  final _rewards = RewardsService();
  final _tasks   = TaskService();
  final _auth    = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  // 25 min work, 5 min break (standard Pomodoro)
  static const _workSecs  = 25 * 60;
  static const _breakSecs = 5  * 60;

  int    _secondsLeft       = _workSecs;
  bool   isBreak            = false;
  bool   isRunning          = false;
  int    sessionsCompleted  = 0;
  String? activeTaskId;
  String? activeTaskTitle;

  Timer? _ticker;

  // Set which task this timer is for — call before start()
  void setTask(String id, String title) {
    activeTaskId    = id;
    activeTaskTitle = title;
    _reset();
  }

  void start() {
    if (isRunning) return;
    isRunning = true;
    notifyListeners();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft > 0) {
        _secondsLeft--;
        notifyListeners();
      } else {
        _onSessionEnd();
      }
    });
  }

  void pause() {
    _ticker?.cancel();
    isRunning = false;
    notifyListeners();
  }

  void reset() {
    _ticker?.cancel();
    _reset();
    notifyListeners();
  }

  // Fires when countdown hits zero
  Future<void> _onSessionEnd() async {
    _ticker?.cancel();
    isRunning = false;

    if (!isBreak) {
      sessionsCompleted++;
      await _rewards.addPoints(userId, 10);      // +10 per Pomodoro

      if (sessionsCompleted >= 4 && activeTaskId != null) {
        await _tasks.completeTask(activeTaskId!); // auto-complete after 4 sessions
        await _rewards.addPoints(userId, 20);     // +20 bonus
      }

      // Switch to break
      isBreak      = true;
      _secondsLeft = _breakSecs;
      notifyListeners();
      start(); // auto-start the break
    } else {
      // Break done → back to work
      isBreak      = false;
      _secondsLeft = _workSecs;
      notifyListeners();
    }
  }

  // "MM:SS" — show this in a Text widget
  String get timeDisplay {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft  % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  // 1.0 → 0.0 — use in CircularProgressIndicator(value: controller.progress)
  double get progress {
    final total = isBreak ? _breakSecs : _workSecs;
    return _secondsLeft / total;
  }

  void _reset() {
    _ticker?.cancel();
    isRunning    = false;
    isBreak      = false;
    _secondsLeft = _workSecs;
    notifyListeners();
  }

  @override
  void dispose() { _ticker?.cancel(); super.dispose(); }
}
