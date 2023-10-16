import 'package:get/get.dart';

import '../data/data.dart';

class BaseController<T> extends GetxController {
  T get repository => GetInstance().find<T>();
  SocketService get socketService => SocketService();
}
