import 'package:get/get.dart';

import '../../../base/base.dart';

class TutorialBinding implements Bindings {
  @override
  void dependencies() => Get.put(TutorialController());
}

class TutorialController extends BaseController {}
