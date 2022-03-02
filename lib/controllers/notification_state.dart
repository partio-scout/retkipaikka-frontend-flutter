import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationState extends ChangeNotifier {
  List<String> notifications = [];

  void setNotifications(List<String> nots) {
    notifications = nots;
    notifyListeners();
  }
}
