import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stoxhero/src/app/app.dart';

final firebaseMessaging = FirebaseMessaging.instance;

class NotificationServices {
  static Future<void> initializeNotificationService(BuildContext context) async {
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    String deviceToken = await firebaseMessaging.getToken() ?? '-';
    print('DeviceToken : $deviceToken');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    final localNotification = FlutterLocalNotificationsPlugin();

    localNotification.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings(
          '@drawable/notification_icon',
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse data) {
        print('onMessageOpenedApp : ${data.toString()}');
        print('onMessageOpenedApp : ${data.payload}');
        if (data.payload != null) {
          Map<String, dynamic> message = jsonDecode(data.payload!);
          if (message.isNotEmpty && message['route'] != null) {
            String route = message['route'];
            handelNotificationClick(route);
          }
        }
      },
    );

    await localNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print('Message data: ${message.data}');

        AndroidNotificationDetails? androidNotificationDetails;

        androidNotificationDetails = AndroidNotificationDetails(
          channel.id,
          channel.name,
        );

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          var notificationDetails = NotificationDetails(
            android: androidNotificationDetails,
          );
          localNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            notificationDetails,
            payload: jsonEncode(message.data),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      print("onMessageOpenedApp: ${message.data}");

      if (message.data.isNotEmpty && message.data['route'] != null) {
        String route = message.data['route'];
        handelNotificationClick(route);
      }
    });
  }

  static void handelNotificationClick(String route) {
    LoginDetailsResponse? userDetails = AppStorage.getUserDetails();
    print('onMessageOpenedApp userDetails : ${userDetails.toJson()}');
    if (userDetails.sId != null) {
      final homeController = Get.find<HomeController>();
      Get.toNamed(AppRoutes.home);
      if (route == 'virtual') homeController.selectedIndex(1);
      if (route == 'tenx') homeController.selectedIndex(2);
      if (route == 'marginx') homeController.selectedIndex(3);
      if (route == 'contest') homeController.selectedIndex(4);
    }
  }
}
