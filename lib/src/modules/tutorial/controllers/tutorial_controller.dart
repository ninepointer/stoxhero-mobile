import 'package:get/get.dart';

import '../../../base/base.dart';
import '../../../data/data.dart';

class TutorialBinding implements Bindings {
  @override
  void dependencies() => Get.put(TutorialController());
}

class TutorialController extends BaseController {}
