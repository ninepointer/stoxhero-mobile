import 'package:get_storage/get_storage.dart';
import 'package:stoxhero/src/data/data.dart';

class AppStorage {
  AppStorage._privateConstructor();

  static final _box = GetStorage();

  static Future setDarkModeStatus(bool data) async {
    await _box.write(AppStorageKeys.darkMode, data);
  }

  static bool getDarkModeStatus() {
    return _box.read(AppStorageKeys.darkMode) ?? false;
  }

  static Future setNewUserStatus(bool data) async {
    await _box.write(AppStorageKeys.newUser, data);
  }

  static bool getNewUserStatus() {
    return _box.read(AppStorageKeys.newUser) ?? true;
  }

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

  static void clearLoginDetails() {
    _box.remove(AppStorageKeys.token);
  }

  static void clearStorage() {
    _box.erase();
  }
}

class AppStorageKeys {
  static const String darkMode = 'darkMode';
  static const String token = 'token';
  static const String userDetails = 'userDetails';
  static const String newUser = 'newUser';
}
