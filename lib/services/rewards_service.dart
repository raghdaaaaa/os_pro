import 'package:cloud_firestore/cloud_firestore.dart';

class RewardsService {
  final _rewards = FirebaseFirestore.instance.collection('rewards');

  // Add points to user — creates doc if first time
  Future<void> addPoints(String userId, int points) async {
    final ref = _rewards.doc(userId);
    final doc = await ref.get();

    if (doc.exists) {
      await ref.update({'points': FieldValue.increment(points)});
    } else {
      await ref.set({'points': points, 'badges': []});
    }

    // Check if a new badge should be awarded
    await _checkBadges(ref);
  }

  // Live stream of user points and badges
  Stream<Map<String, dynamic>> getUserRewards(String userId) {
    if (userId.isEmpty) return const Stream.empty();

    return _rewards
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? doc.data()! : {'points': 0, 'badges': []});
  }

  // Award a badge when user hits a point milestone
  Future<void> _checkBadges(DocumentReference ref) async {
    final doc = await ref.get();
    final data = doc.data() as Map<String, dynamic>;
    final points = data['points'] as int? ?? 0;
    final badges = List<String>.from(data['badges'] ?? []);

    final milestones = {
      50: '🥉 Starter',
      100: '🥈 Achiever',
      250: '🥇 Pro',
      500: '🏆 Champion',
      1000: '👑 Legend',
    };

    bool changed = false;
    milestones.forEach((threshold, badge) {
      if (points >= threshold && !badges.contains(badge)) {
        badges.add(badge);
        changed = true;
      }
    });

    if (changed) await ref.update({'badges': badges});
  }
}
