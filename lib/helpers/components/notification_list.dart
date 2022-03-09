import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/components/notification_card.dart';
import 'package:retkipaikka_flutter/models/app_notification_model.dart';

class NotificationList extends StatelessWidget {
  const NotificationList(
      {Key? key, required this.notifications, this.allowEditing = false})
      : super(key: key);
  final List<AppNotification> notifications;
  final bool allowEditing;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var noti in notifications) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: NotificationCard(
                allowEditing: allowEditing, notification: noti),
          )
        ]
      ],
    );
  }
}
