import 'dart:convert';

import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const kUserKey = "RETKIPAIKKA_USER";
  static const kAccessToken = "RETKIPAIKKA_TOKEN";
  static const kThemeMode = "RETKIPAIKKA_THEME";
  static Future<bool> saveToPrefs(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> saveLogin(AdminUser user) async {
    if (user.token == null) {
      return false;
    }
    return saveToPrefs(kUserKey, jsonEncode(AdminUser.toJson(user)))
        .then((value) => saveToPrefs(kAccessToken, user.token!));
  }

  static Future<bool> deleteLogin() async {
    return deleteFromPrefs(kAccessToken)
        .then((value) => deleteFromPrefs(kUserKey));
  }

  static Future<String?> getSavedToken() async {
    return await getStringFromPrefs(kAccessToken);
  }

  static Future<String?> getThemeMode() async {
    return await getStringFromPrefs(kThemeMode);
  }

  static Future<AdminUser?> getSavedUser() async {
    String? value = await getStringFromPrefs(kUserKey);
    if (value != null) {
      return AdminUser.fromJson(jsonDecode(value));
    }
    return null;
  }

  static Future<bool> deleteFromPrefs(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<String?> getStringFromPrefs(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
