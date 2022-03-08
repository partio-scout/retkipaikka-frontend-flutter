import 'package:flutter/material.dart';


class NotificationState extends ChangeNotifier {
  List<String> notifications = [];

  void setNotifications(List<String> nots) {
    notifications = nots;
    notifyListeners();
  }
}
