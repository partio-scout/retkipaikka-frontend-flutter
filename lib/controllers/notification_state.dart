import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/models/app_notification_model.dart';

class NotificationState extends ChangeNotifier {
  List<AppNotification> notifications = [];
  List<AppNotification> adminNotifications = [];
  void setNotifications(List<AppNotification> notis) {
    notifications = notis;
    notifyListeners();
  }

  void setAdminNotifications(List<AppNotification> notis) {
    adminNotifications = notis;
    notifyListeners();
  }
}
