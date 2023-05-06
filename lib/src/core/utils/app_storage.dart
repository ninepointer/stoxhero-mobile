import 'package:get_storage/get_storage.dart';

class AppStorage {
  AppStorage._privateConstructor();

  static final _box = GetStorage();

  static void clearStorage() {
    _box.erase();
  }
}

class AppStorageKeys {}
