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
        print('onMessageClicked LocalNotification : ${data.toString()}');
        print('onMessageClicked LocalNotification : ${data.payload}');
        if (data.payload != null) {
          Map<String, dynamic> message = jsonDecode(data.payload!);
          handelNotificationClick(message, isLocal: true);
        }
      },
    );

    await localNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        AndroidNotificationDetails? androidNotificationDetails;
        androidNotificationDetails = AndroidNotificationDetails(
          channel.id,
          channel.name,
          color: AppColors.lightGreen,
          importance: Importance.max,
          priority: Priority.max,
          styleInformation: BigTextStyleInformation(
            message.notification?.body ?? '',
          ),
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
      print("onMessageClicked FirebaseMessaging : $message");
      print("onMessageClicked FirebaseMessaging: ${message.data}");
      handelNotificationClick(message.data);
    });
  }

  static void handelNotificationClick(dynamic messageData, {bool isLocal = false}) async {
    print('onMessageClicked : isLocal : $isLocal');
    print('onMessageClicked : $messageData');

    LoginDetailsResponse? userDetails = AppStorage.getUserDetails();
    Map<String, dynamic> actionData = jsonDecode(messageData['actions']);
    String route = actionData['route'];

    if (userDetails.sId != null) {
      final homeController = Get.find<HomeController>();
      if (isLocal) Get.toNamed(AppRoutes.home);
      if (route == 'virtual') homeController.selectedIndex(1);
      if (route == 'tenx') homeController.selectedIndex(2);
      if (route == 'marginx') homeController.selectedIndex(3);
      if (route == 'testzone') homeController.selectedIndex(4);
      if (route == 'analytics') Get.toNamed(AppRoutes.analytics);
      if (route == 'careers') Get.toNamed(AppRoutes.careers);
      if (route == 'profile') Get.toNamed(AppRoutes.profile);
      if (route == 'wallet') Get.toNamed(AppRoutes.wallet);
    }
  }
}
