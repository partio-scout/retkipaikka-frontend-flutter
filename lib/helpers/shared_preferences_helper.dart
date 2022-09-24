import 'dart:convert';

import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const kUserKey = "RETKIPAIKKA_USER";
  static const kAccessToken = "RETKIPAIKKA_TOKEN";
  static const kThemeMode = "RETKIPAIKKA_THEME";
  static const kUserFavourites = "RETKIPAIKKA_FAVOURITES";
  static const kSeenNotifications = "RETKIPAIKKA_NOTIFICATIONS";
  static const kAppLocale = "RETKIPAIKKA_LOCALE";
  static Future<bool> saveToPrefs(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> saveLocale(String name) {
    return saveToPrefs(kAppLocale, name);
  }

  static Future<String?> getLocale() async {
    return getStringFromPrefs(kAppLocale);
  }

  static Future<bool> saveLogin(AdminUser user) async {
    if (user.token == null) {
      return false;
    }
    return saveToPrefs(kUserKey, jsonEncode(AdminUser.toJson(user)))
        .then((value) => saveToPrefs(kAccessToken, user.token!));
  }

  static Future<List<dynamic>?> getUserFavourites() async {
    String? val = await getStringFromPrefs(kUserFavourites);
    if (val != null) {
      return jsonDecode(val);
    }
    return null;
  }

  static Future<bool> addUserFavourite(String id) async {
    List<dynamic> currentFavourites = await getUserFavourites() ?? [];
    currentFavourites.add(id);
    String encoded = jsonEncode(currentFavourites);
    return saveToPrefs(kUserFavourites, encoded);
  }

  static Future<bool> removeUserFavourite(String id) async {
    List<dynamic> currentFavourites = await getUserFavourites() ?? [];

    currentFavourites =
        currentFavourites.where((element) => element != id).toList();

    String encoded = jsonEncode(currentFavourites);
    return saveToPrefs(kUserFavourites, encoded);
  }

  static Future<List<dynamic>?> getNotificationIds() async {
    String? res = await getStringFromPrefs(kSeenNotifications);

    if (res != null) {
      return jsonDecode(res);
    }
    return null;
  }

  static Future<bool> saveNotificationId(String id) async {
    List<dynamic> currentNotis = await getNotificationIds() ?? [];

    currentNotis.add(id);

    return saveToPrefs(kSeenNotifications, jsonEncode(currentNotis));
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
