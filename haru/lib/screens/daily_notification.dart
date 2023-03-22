import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future dailyAtTimeNotification(List<String> data) async {
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

  if (result ?? false) {
    // ios기기
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup('id');

    for (int i = 0; i < data.length; i++) {
      int hour = int.parse(data[i].substring(0, 2));
      if (data[i].substring(7, 9) == "PM") {
        hour += 12;
      }
      int minute = int.parse(data[i].substring(3, 5));
      await flutterLocalNotificationsPlugin.zonedSchedule(
          i, notiTitle, notiDescription, _setNotiTime(hour, minute), detail,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
    }
  } else {
    // android 기기
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup('id');

    for (int i = 0; i < data.length; i++) {
      int hour = int.parse(data[i].substring(0, 2));
      if (data[i].substring(7, 9) == "PM") {
        hour += 12;
      }
      print(hour);
      int minute = int.parse(data[i].substring(3, 5));
      await flutterLocalNotificationsPlugin.zonedSchedule(
          i, notiTitle, notiDescription, _setNotiTime(hour, minute), detail,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
    }
  }
}

tz.TZDateTime _setNotiTime(int hour, int minute) {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  final now = tz.TZDateTime.now(tz.local);
  var scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

  return scheduledDate;
}
