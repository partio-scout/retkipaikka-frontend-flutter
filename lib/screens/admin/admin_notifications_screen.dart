import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/notification_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/notification_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/notification_list.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/app_notification_model.dart';
import 'package:retkipaikka_flutter/screens/admin/components/notification_builder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdminNotificationsScreen extends HookWidget {
  AdminNotificationsScreen({Key? key}) : super(key: key);
  final NotificationApi notificationApi = ApiService().notificationApi;
  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.only(left: 100, right: 100, top: 30)
        : const EdgeInsets.only(left: 10, right: 10, top: 30);

    useEffect(() {
      notificationApi.getAllNotifications().then((value) {
        context.read<NotificationState>().setAdminNotifications(value);
      }).catchError((err) {
        AlertHelper.displayErrorAlert(err, context);
      });

      return null;
    }, []);
    List<AppNotification> adminNotis =
        context.select((NotificationState s) => s.adminNotifications);
    return ListView(children: [
      Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationBuilder(),
            const SizedBox(
              height: 50,
            ),
            NotificationList(
              notifications: adminNotis,
              allowEditing: true,
            )
          ],
        ),
      ),
    ]);
  }
}
