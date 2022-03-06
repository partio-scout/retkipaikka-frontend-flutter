import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  bool isLoading = false;
  bool scrollEnabled = true;
  ScrollController scrollController = ScrollController();
  String? error;
  AdminUser? currentUser;
  bool isLoggedIn = false;
  GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey();
  void _setLoading(bool state) {
    isLoading = state;
    notifyListeners();
  }

  void _setError(String? err) {
    error = err;
    notifyListeners();
  }

  void setScroll(bool state) {
    scrollEnabled = state;
    notifyListeners();
  }

  static void setLoading(BuildContext context, bool state) {
    context.read<AppState>()._setLoading(state);
  }

  static void setError(BuildContext context, String? error) {
    context.read<AppState>()._setError(error);
  }

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
    // mainScaffoldKey.currentState?.openEndDrawer();
  }

  void closeDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
    //mainScaffoldKey.currentState?.openDrawer();
  }

  Future<bool> handleAfterLogin(AdminUser user) async {
    currentUser = user;
    isLoggedIn = true;
    bool res = await SharedPreferencesHelper.saveLogin(user);
    notifyListeners();
    return res;
  }

  void setLogin(AdminUser user) {
    currentUser = user;
    isLoggedIn = true;
    notifyListeners();
  }

  Future<bool> handleAfterLogout() async {
    currentUser = null;
    isLoggedIn = false;
    bool res = await SharedPreferencesHelper.deleteLogin();
    notifyListeners();
    return res;
  }
}
