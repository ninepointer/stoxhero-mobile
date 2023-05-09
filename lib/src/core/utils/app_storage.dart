import 'package:get_storage/get_storage.dart';
import 'package:stoxhero/src/data/data.dart';

class AppStorage {
  AppStorage._privateConstructor();

  static final _box = GetStorage();

  static Future setToken(String? data) async {
    await _box.write(AppStorageKeys.token, data);
  }

  static String? getToken() {
    return _box.read(AppStorageKeys.token);
  }

  static Future setUserDetails(LoginDetailsResponse data) async {
    await _box.write(AppStorageKeys.userDetails, data.toJson());
  }

  static LoginDetailsResponse getUserDetails() {
    return LoginDetailsResponse.fromJson(_box.read(AppStorageKeys.userDetails));
  }

  static void clearStorage() {
    _box.erase();
  }
}

class AppStorageKeys {
  static const String token = 'token';
  static const String userDetails = 'userDetails';
}
