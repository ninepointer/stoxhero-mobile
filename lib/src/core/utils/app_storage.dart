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

  static Future setReadSetting(ReadSettingResponse? data) async {
    await _box.write(AppStorageKeys.readSetting, data?.toJson());
  }

  static ReadSettingResponse getReadSetting() {
    return ReadSettingResponse.fromJson(_box.read(AppStorageKeys.readSetting));
  }

  static Future<void> setCourseUserStarRating(
      String courseId, int count) async {
    await _box.write('${AppStorageKeys.courseStarCount}_$courseId', count);
  }

  static int getCourseUserStarRating(String courseId) {
    return _box.read('${AppStorageKeys.courseStarCount}_$courseId') ?? 0;
  }

  static Future setCourseSidForStarRating(String? sId) async {
    await _box.write(AppStorageKeys.courseSid, sId);
  }

  static String getCourseSidForStarRating() {
    return _box.read(AppStorageKeys.courseSid) ?? "";
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
  static const String courseStarCount = "starCount";
  static const String readSetting = "readSetting";
  static const String courseSid = "courseSid";
}
