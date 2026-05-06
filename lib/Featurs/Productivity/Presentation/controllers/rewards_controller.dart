import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:brain_stack/services/rewards_service.dart';

// ──────────────────────────────────────────────────────────
// WHAT THIS CONTROLLER DOES (for teammates):
//
//  • rewardsStream            → live points + badges (use with StreamBuilder)
//  • badgeLabel(points)       → returns badge name e.g. "🥇 Pro"
//  • progressToNext(points)   → 0.0–1.0 for the badge progress bar
//  • pointsToNext(points)     → how many more points until next badge
// ──────────────────────────────────────────────────────────

class RewardsController extends ChangeNotifier {
  final _rewards = RewardsService();
  final _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser?.uid ?? '';

  // Use this with StreamBuilder — auto-updates when points change
  Stream<Map<String, dynamic>> get rewardsStream {
    if (userId.isEmpty) return const Stream.empty();
    return _rewards.getUserRewards(userId);
  }

  // Returns badge name based on points total
  String badgeLabel(int points) {
    if (points >= 1000) return '👑 Legend';
    if (points >= 500) return '🏆 Champion';
    if (points >= 250) return '🥇 Pro';
    if (points >= 100) return '🥈 Achiever';
    if (points >= 50) return '🥉 Starter';
    return '🌱 Beginner';
  }

  // 0.0 → 1.0 — for the progress bar toward next badge
  double progressToNext(int points) {
    final steps = [0, 50, 100, 250, 500, 1000];
    for (int i = 0; i < steps.length - 1; i++) {
      if (points < steps[i + 1]) {
        return (points - steps[i]) / (steps[i + 1] - steps[i]);
      }
    }
    return 1.0;
  }

  // How many points left until next badge
  int pointsToNext(int points) {
    for (final target in [50, 100, 250, 500, 1000]) {
      if (points < target) return target - points;
    }
    return 0;
  }
}
