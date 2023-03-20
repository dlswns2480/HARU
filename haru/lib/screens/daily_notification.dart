import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future dailyAtTimeNotification() async {
  const notiTitle = '사용자 지정 시간 알림 테스트';
  const notiDescription = '테스트메시지';

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final result = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  var ios = const DarwinNotificationDetails();

  var android = const AndroidNotificationDetails(
    'id',
    notiTitle,
    importance: Importance.max,
    priority: Priority.max,
  );

  var detail = NotificationDetails(
    android: android,
    iOS: ios,
  );

  if (result!) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup('id');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // id는 unique해야합니다. int값
      notiTitle,
      notiDescription,
      _setNotiTime(),
      detail,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

tz.TZDateTime _setNotiTime() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  final now = tz.TZDateTime.now(tz.local);
  var scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 21, 20);

  return scheduledDate;
}
