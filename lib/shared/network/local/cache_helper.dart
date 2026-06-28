import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }

    return false;
  }

  static bool? getBool({
    required String key,
  }) {
    return sharedPreferences!.getBool(key);
  }

  static Future<bool> saveString({
  required String key,
  required String value,
}) async {
  return await sharedPreferences!.setString(
    key,
    value,
  );
}

static String? getString({
  required String key,
}) {
  return sharedPreferences?.getString(key);
}

static Future<bool> removeData({
  required String key,
}) async {
  return await sharedPreferences!.remove(key);
}

static Future<bool> saveBoolean({
  required String key,
  required bool value,
}) async {
  return await sharedPreferences!.setBool(key, value);
}

static bool? getBoolean({
  required String key,
}) {
  return sharedPreferences?.getBool(key);
}
}