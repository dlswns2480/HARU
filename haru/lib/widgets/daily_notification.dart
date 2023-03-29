import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Person {
  String title;
  String knowledge;
  String imagePath;
  String author;

  Person({
    required this.title,
    required this.knowledge,
    required this.imagePath,
    required this.author,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      title: json['title'],
      knowledge: json['knowledge'],
      imagePath: json['imagePath'],
      author: json['author'],
    );
  }
}

Future<String> _loadPersonAsset() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<String> getPersonDataTitle() async {
  String jsonString = await _loadPersonAsset();
  var jsonResponse = json.decode(jsonString);
  return jsonResponse['title'];
}

Future<String> getPersonDataDescription() async {
  String jsonString = await _loadPersonAsset();
  var jsonResponse = json.decode(jsonString);
  return jsonResponse['knowledge'];
}

Future dailyAtTimeNotification(List<String> data) async {
  Future<String> jsonTitleData = getPersonDataTitle();
  Future<String> jsonDescriptionData = getPersonDataDescription();
  var notiTitle = await jsonTitleData;
  var notiDescription = await jsonDescriptionData;

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

  var android = AndroidNotificationDetails(
    'id',
    notiTitle,
    importance: Importance.max,
    priority: Priority.max,
  );

  var detail = NotificationDetails(
    android: android,
    iOS: ios,
  );

  if (result != null) {
    // ios기기
    if (result) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.deleteNotificationChannelGroup('id');
      var data1 = data.toSet();
      data = data1.toList();
      for (int i = 0; i < data.length; i++) {
        int hour = int.parse(data[i].substring(0, 2));
        if (data[i].substring(7, 9) == "PM") {
          hour += 12;
        } else {
          if (hour == 12) {
            hour -= 12;
          }
        }
        int minute = int.parse(data[i].substring(3, 5));
        await flutterLocalNotificationsPlugin.zonedSchedule(
            i, notiTitle, notiDescription, _setNotiTime(hour, minute), detail,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time);
      }
    }
  } else {
    // android 기기
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannelGroup('id');
    var data1 = data.toSet();
    data = data1.toList();
    for (int i = 0; i < data.length; i++) {
      int hour = int.parse(data[i].substring(0, 2));
      if (data[i].substring(7, 9) == "PM") {
        hour += 12;
      } else {
        if (hour == 12) {
          hour -= 12;
        }
      }

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
