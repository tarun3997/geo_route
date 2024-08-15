import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geo_route/screens/notification_screen.dart';
import 'package:geo_route/screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );


  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.instance.getToken().then((value) {
    print("Token: $value");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("onMessage: ${message.messageId}");
    print("Message data: ${message.data}");

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      showLocalNotification(message);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onMessageOpenedApp: $message");
    Navigator.pushNamed(navigatorKey.currentState!.context, '/notification',
        arguments: {"message": json.encode(message.data)});
  });

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      Navigator.pushNamed(navigatorKey.currentState!.context, '/notification',
          arguments: {"message": json.encode(message.data)});
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("_firebaseMessagingBackgroundHandler: ${message.messageId}");
  print("Message data: ${message.data}");
}

void showLocalNotification(RemoteMessage message) async {
  try {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
      icon: '@mipmap/ic_launcher',
    );


    const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
  } catch (e) {
    print('Error showing local notification: $e');
  }
}


Future selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  navigatorKey.currentState?.pushNamed('/notification', arguments: {"message": payload});
}

Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
  // Handle the notification tapped logic here for iOS older versions
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title ?? ''),
      content: Text(body ?? ''),
      actions: [
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            navigatorKey.currentState?.pushNamed('/notification', arguments: {"message": payload});
          },
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      routes: {'/notification': ((context) => const NotificationScreen())},
      home: const SplashScreen(),
    );
  }
}
