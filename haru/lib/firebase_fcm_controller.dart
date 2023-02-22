import 'package:firebase_messaging/firebase_messaging.dart';

class FCMController {
  Future<void> init() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
  }
}
