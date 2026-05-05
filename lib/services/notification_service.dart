import 'package:firebase_messaging/firebase_messaging.dart';

// ──────────────────────────────────────────────────────────
// IS THIS IMPORTANT?
// Yes — but only for push notifications (FCM).
// Without it the app still runs fine.
// It is needed when you want to:
//   • Send a notification when a task deadline is near
//   • Notify user when they earn a badge
// For Phase 1 (Login/Register/Home/Profile/AddTask) you don't
// need it yet — but it must exist so main.dart can import it.
// ──────────────────────────────────────────────────────────

class NotificationService {
  final _fcm = FirebaseMessaging.instance;

  // Call once at app startup in main.dart
  Future<void> initialize() async {
    // Ask user for permission to send notifications
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    // Listen for notifications when app is open
    FirebaseMessaging.onMessage.listen((message) {
      // Your teammates can show a dialog/snackbar here using the title:
      // message.notification?.title
      // message.notification?.body
      print('Notification received: ${message.notification?.title}');
    });
  }

  // Returns this device's FCM token — saved to Firestore on login
  Future<String?> getToken() async {
    return await _fcm.getToken();
  }
}
