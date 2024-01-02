import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:url_launcher/url_launcher.dart';

final firebaseMessaging = FirebaseMessaging.instance;

@pragma("vm:entry-point")
Future<void> onBackgroundFirebaseMessage(RemoteMessage message) async {
  print('FirebaseMessaging : ${message.toMap()}');
  NotificationServices.showNotification(message);
}

@pragma("vm:entry-point")
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  print('onActionReceivedMethod : ${receivedAction.payload}');
  NotificationServices.handelNotificationClick(receivedAction.payload);
}

class NotificationServices {
  static Future<void> initializeNotificationService(BuildContext context) async {
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );

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

    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'high_importance_channel',
    //   'High Importance Notifications',
    //   importance: Importance.max,
    // );

    // final localNotification = FlutterLocalNotificationsPlugin();

    // localNotification.initialize(
    //   InitializationSettings(
    //     android: AndroidInitializationSettings(
    //       '@drawable/notification_icon',
    //     ),
    //   ),
    //   onDidReceiveNotificationResponse: (NotificationResponse data) {
    //     print('onMessageClicked LocalNotification : ${data.toString()}');
    //     print('onMessageClicked LocalNotification : ${data.payload}');
    //     if (data.payload != null) {
    //       Map<String, dynamic> message = jsonDecode(data.payload!);
    //       handelNotificationClick(message, isLocal: true);
    //     }
    //   },
    // );

    // await localNotification
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    FirebaseMessaging.onBackgroundMessage(onBackgroundFirebaseMessage);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print('FirebaseMessaging : ${message.toMap()}');
        showNotification(message);
        // Uint8List response;
        // String? mediaUrl = message.data['mediaUrl'];

        // AndroidNotificationDetails? androidNotificationDetails;
        // RemoteNotification? notification = message.notification;
        // AndroidNotification? android = message.notification?.android;

        // if (mediaUrl != null && mediaUrl.isNotEmpty) {
        //   response = await Get.find<NetworkService>().getImageBytes(mediaUrl);
        //   androidNotificationDetails = AndroidNotificationDetails(
        //     channel.id,
        //     channel.name,
        //     priority: Priority.max,
        //     importance: Importance.max,
        //     color: AppColors.lightGreen,
        //     icon: '@drawable/notification_icon',
        //     styleInformation: BigPictureStyleInformation(
        //       ByteArrayAndroidBitmap.fromBase64String(base64.encode(response)),
        //     ),
        //   );
        // } else {
        //   androidNotificationDetails = AndroidNotificationDetails(
        //     channel.id,
        //     channel.name,
        //     priority: Priority.max,
        //     importance: Importance.max,
        //     color: AppColors.lightGreen,
        //     icon: '@drawable/notification_icon',
        //     styleInformation: BigTextStyleInformation(
        //       message.notification?.body ?? '',
        //     ),
        //   );
        // }

        // if (notification != null && android != null) {
        //   var notificationDetails = NotificationDetails(
        //     android: androidNotificationDetails,
        //   );

        //   localNotification.show(
        //     notification.hashCode,
        //     notification.title,
        //     notification.body,
        //     notificationDetails,
        //     payload: jsonEncode(message.data),
        //   );
        // }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageClicked FirebaseMessaging : $message");
      print("onMessageClicked FirebaseMessaging: ${message.data}");
      handelNotificationClick(message.data);
    });
  }

  static void showNotification(RemoteMessage message) {
    String? title = message.data['title'];
    String? body = message.data['body'];
    String? mediaUrl = message.data['mediaUrl'];
    String? actionLabel = message.data['actionLable'];

    Map<String, String?> convertedMap = convertDynamicToStringMap(message.data);

    AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        )
      ],
    );

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(9999),
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: title,
        body: body,
        bigPicture: mediaUrl,
        notificationLayout: NotificationLayout.BigPicture,
        backgroundColor: AppColors.lightGreen,
        payload: convertedMap,
      ),
      actionButtons: [
        if (actionLabel != null || actionLabel != "")
          NotificationActionButton(
            key: 'key',
            label: actionLabel ?? "View",
            color: AppColors.lightGreen,
          )
      ],
    );
  }

  static Map<String, String?> convertDynamicToStringMap(Map<String, dynamic> dynamicMap) {
    Map<String, String?> stringMap = {};

    dynamicMap.forEach((key, value) {
      if (value is String || value == null) {
        stringMap[key] = value as String?;
      } else {
        stringMap[key] = value.toString();
      }
    });

    return stringMap;
  }

  static void handelNotificationClick(dynamic messageData, {bool isLocal = false}) async {
    print('onMessageClicked : isLocal : $isLocal');
    print('onMessageClicked : $messageData');

    LoginDetailsResponse? userDetails = AppStorage.getUserDetails();
    Map<String, dynamic> actionData = jsonDecode(messageData['actions']);
    bool isExternal = (actionData['external'] == 'true');
    String route = actionData['route'];
    print('onMessageClicked : actionData : $actionData');
    print('onMessageClicked : $route');
    if (isExternal) {
      final Uri url = Uri.parse(route);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } else {
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
}
