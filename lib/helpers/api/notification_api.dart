import 'dart:convert';

import 'package:retkipaikka_flutter/helpers/api/base_api.dart';
import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';
import 'package:retkipaikka_flutter/models/app_notification_model.dart';

class NotificationApi extends BaseApi {
  NotificationApi({String route = "/Notifications"}) : super(route);
  

  List<AppNotification> jsonToNotifications(List<dynamic> json) {
    List<AppNotification> returnVal = [];

    for (var noti in json) {
      returnVal.add(AppNotification.fromJson(noti));
    }

    return returnVal;
  }


  Future<AppNotification?> getNotificationForFrontpage() async{

    List<dynamic>? ignoreIds = await SharedPreferencesHelper.getNotificationIds();

    Map<String,dynamic> where = {
      "display_frontpage":true
    };

    if(ignoreIds != null && ignoreIds.isNotEmpty){
      where["notification_id"] = {"nin":ignoreIds};
    }
    
    Map<String, dynamic> filter = {
      "filter":jsonEncode({
        "where": where,
        "order": "updatedAt DESC",
        "limit":1,
      })
  };

   

    List<AppNotification> parsed = await _getNotifications(filter);

    if(parsed.isNotEmpty){
      return parsed[0];
    }
    return null;
  }

  Future<List<AppNotification>> getNotificationsForList() {
    Map<String, dynamic> filter = {
      "filter":jsonEncode({
        "where": {"enabled": true},
        "order": "updatedAt DESC"
      })
      
    };
    return _getNotifications(filter);
  }

  Future<List<AppNotification>> getAllNotifications() {
    Map<String, dynamic> filter = {"filter":jsonEncode({
      "order": "updatedAt DESC"
    })
    
    };

    return _getNotifications(filter);
  }

  Future<List<AppNotification>> _getNotifications(
      Map<String, dynamic> filter) async {
    dynamic response = await get("", filter);

    List<dynamic> toParse = parseResponse(response);

    return jsonToNotifications(toParse);
  }


  Future<void> createNotification(Map<String,dynamic> payload)async{

    dynamic response = await post("",payload);

    return parseResponse(response);
  }


  Future<void> editNotification(String notificationId, Map<String,dynamic> payload)async{
    dynamic response = await patch("/"+notificationId,payload);

    return parseResponse(response);
  }

  Future<void> deleteNotification(String notificationId) async{
    dynamic response = await delete("/"+notificationId,{});

    return parseResponse(response);

  }
}
