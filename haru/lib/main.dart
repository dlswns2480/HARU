import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haru/screens/home_screen.dart';
import 'package:haru/screens/initial_alarm_screen.dart';
import 'package:haru/screens/initial_screen.dart';
import 'package:logger/logger.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// firebase_options import 후 options 지정을 해줘야 init이 정상적으로 진행됨
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // setting 함수
  await setupFlutterNotifications();

  /// main 실행
  runApp(const MyApp());
}

// 필요 변수
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false; // 셋팅여부 판단 flag

/// 셋팅 메소드
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title

    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // // iOS foreground notification 권한
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // // IOS background 권한 체킹 , 요청
  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // 토큰 요청
  getToken();
  // 셋팅flag 설정
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> getToken() async {
  // ios
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  String? token;
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    token = await FirebaseMessaging.instance.getAPNSToken();
  }
  // aos
  else {
    token = await FirebaseMessaging.instance.getToken();
  }
  logger.i("fcmToken : $token");
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // foreground 수신처리
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // background 수신처리
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // 내가 지정한 그 알람이면? 지ㄴ정한 화면으로 이동
    if (message.data['data1'] == 'value1') {
      Navigator.pushNamed(
          context, '/notification'); // main에서는 이동불가 Home에 들어와서 해줘야함
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        /// routes 설정
        initialRoute: '/',
        routes: {
          '/login': (context) => const InitialScreen(),
          '/home': (context) => const HomeScreen(),
          '/notification': (context) => const InitialAlarm(),
        },
        home: const HomeScreen());
  }
}

/// fcm 배경 처리 (종료되어있거나, 백그라운드에 경우)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications(); // 셋팅 메소드
  showFlutterNotification(message); // 로컬노티
}

/// fcm 전경 처리 - 로컬 알림 보이기
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  print(
      "------------------------------------------------------------------------------------------------");
  print(message.data);
  print(
      "------------------------------------------------------------------------------------------------");
  if (notification != null && android != null && !kIsWeb) {
    print("Message also ~~~~~~~~~~");
    // 웹이 아니면서 안드로이드이고, 알림이 있는경우
    flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,

          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
          playSound: true,
        ),
      ),
    );
  }
}
