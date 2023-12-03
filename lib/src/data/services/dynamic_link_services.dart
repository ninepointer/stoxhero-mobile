import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:stoxhero/src/app/app.dart';

final firebaseDynamicLink = FirebaseDynamicLinks.instance;

class DynamicLinkServices {
  static Future<void> initializeDynamicLink() async {
    print('DynamicLink initializeDynamicLink');
    firebaseDynamicLink.onLink.listen((PendingDynamicLinkData dynamicLinkData) {
      print('DynamicLink onLink : ${dynamicLinkData.link}');
      String url = dynamicLinkData.link.toString();
      if (url.isEmpty) return;
      handleDeepLink(url);
    }).onError((e) {
      print('DynamicLink Error : $e');
    });
    initializeUniLink();
  }

  static Future<void> initializeUniLink() async {
    try {
      final dynamicLinkData = await firebaseDynamicLink.getInitialLink();
      print('DynamicLink getInitialLink : ${dynamicLinkData?.link}');
      if (dynamicLinkData == null) return;
      handleDeepLink(dynamicLinkData.link.path);
    } catch (e) {
      print('DynamicLink Error : $e');
    }
  }

  static void handleDeepLink(String url) {
    print('DynamicLink handleDeepLink : $url');

    try {
      Uri uri = Uri.parse(url);
      String? code = uri.queryParameters['campaign'];

      if (code != null) {
        print('DynamicLink Code : $code');
        Get.find<AuthController>().campaignCode(code);
        SnackbarHelper.showSnackbar('Code Captured : $code');
      }
    } catch (e) {
      print('DynamicLink Error : $e');
    }
  }
}
