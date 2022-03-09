import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/components/base_dialog.dart';
import 'package:retkipaikka_flutter/models/app_notification_model.dart';
import 'package:retkipaikka_flutter/screens/admin/components/notification_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {Key? key, required this.notification, this.allowEditing = false})
      : super(key: key);
  final AppNotification notification;
  final bool allowEditing;
  Future<void> _launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: allowEditing
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) => BaseDialog(
                        children: [
                          NotificationBuilder(
                            initialData: notification,
                          )
                        ],
                      ),
                    );
                  }
                : null,
            leading: const Icon(Icons.circle_notifications_rounded),
            title: Text(notification.title),
            subtitle: Text(notification.text),
            trailing: notification.updatedAt != null
                ? Text(notification.updatedAtParsed() ?? "-")
                : null,
          ),
          if (notification.linkText != null && notification.linkUrl != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(notification.linkText!),
                  onPressed: () {
                    _launchInWebViewOrVC(notification.linkUrl!);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
