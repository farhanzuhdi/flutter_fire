import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/core/ff_function.dart';
import 'package:flutter_fire/module/login/login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class IntroState with ChangeNotifier {
  BuildContext context;
  ValueNotifier userCredential = ValueNotifier('');
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  IntroState({required this.context}) {
    setupInteractedMessage();
    Future.delayed(const Duration(milliseconds: 1000), () {
      init();
    });
  }

  Future<void> setupInteractedMessage() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
              ),
            ));
        init();
      }
    });
  }

  init() async {
    if (await fffunction.getSharedPreferences(
            type: "getString", key: "email") !=
        "") {
      try {
        if (!context.mounted) return;
        fffunction.login(context);
      } catch (e) {
        if (!context.mounted) return;
        fffunction.showMessageSnackBar(context, e.toString());
      }
    } else {
      if (!context.mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}
