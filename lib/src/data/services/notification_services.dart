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
      if (route == 'market') {
        homeController.selectedIndex(1);
      }
      if (route == 'tenxtrading') {
        homeController.selectedIndex(2);
        Get.find<TenxTradingController>().loadData();
      }
      if (route == 'marginxs') {
        homeController.selectedIndex(3);
        Get.find<MarginXController>().loadData();
      }
      if (route == 'testzone') {
        homeController.selectedIndex(4);
      }

      if (route == 'collegetestzone') {
        Get.toNamed(AppRoutes.collegeContest);
        Get.find<CollegeContestController>().loadData();
      }
      if (route == 'portfolio') {
        Get.toNamed(AppRoutes.portfolio);
        Get.find<PortfolioController>().loadData();
      }
      if (route == 'internship') {
        Get.toNamed(AppRoutes.internship);
        Get.find<InternshipController>().loadData();
      }
      if (route == 'marketguru') {
        Get.toNamed(AppRoutes.analytics);
        Get.find<AnalyticsController>().loadData();
      }
      if (route == 'tutorials') {
        Get.toNamed(AppRoutes.tutorial);
        Get.find<TutorialController>().loadData();
      }

      if (route == 'profile') {
        Get.toNamed(AppRoutes.profile);
        Get.find<ProfileController>().loadData();
      }
      if (route == 'wallet') {
        Get.toNamed(AppRoutes.wallet);
        Get.find<WalletController>().loadData();
      }
      if (route == 'referrals') {
        Get.toNamed(AppRoutes.referrals);
        Get.find<ReferralsController>().loadData();
      }
      if (route == 'faqs') {
        Get.toNamed(AppRoutes.faq);
      }
    }
  }
}
