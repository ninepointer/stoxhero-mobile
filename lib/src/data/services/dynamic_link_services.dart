import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:stoxhero/src/app/app.dart';

final firebaseDynamicLink = FirebaseDynamicLinks.instance;

class DynamicLinkServices {
  static Future<void> initializeDynamicLink() async {
    print('DynamicLink initializeDynamicLink');
    firebaseDynamicLink.onLink.listen((PendingDynamicLinkData dynamicLinkData) {
      print('DynamicLink onLink : ${dynamicLinkData.link}');
      handleDeepLink(dynamicLinkData);
    }).onError((e) {
      print('DynamicLink Error : $e');
    });
    initializeUniLink();
  }

  static Future<void> initializeUniLink() async {
    try {
      PendingDynamicLinkData? dynamicLinkData =
          await firebaseDynamicLink.getInitialLink();
      print('DynamicLink getInitialLink : ${dynamicLinkData?.link}');
      handleDeepLink(dynamicLinkData);
    } catch (e) {
      print('DynamicLink Error : $e');
    }
  }

  static void handleDeepLink(PendingDynamicLinkData? dynamicLinkData) {
    print('DynamicLink handleDeepLink : ${dynamicLinkData?.link.toString()}');
    if (dynamicLinkData != null) {
      try {
        Uri url = dynamicLinkData.link;
        String? code = url.queryParameters['campaign'];
        if (code != null) {
          print('DynamicLink Code : $code');
          Get.find<AuthController>().campaignCode(code);
          // SnackbarHelper.showSnackbar('Code Captured : $code');
        }
      } catch (e) {
        print('DynamicLink Error : $e');
      }
    }
  }
}
