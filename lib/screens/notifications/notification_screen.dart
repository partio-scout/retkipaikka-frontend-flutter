import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/notification_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/notification_api.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';
import 'package:retkipaikka_flutter/helpers/components/notification_list.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/app_notification_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NotificationsScreen extends HookWidget {
  NotificationsScreen({Key? key}) : super(key: key);
  final NotificationApi notificationApi = NotificationApi();

  Future<void> refresh(BuildContext context) {
    return notificationApi.getNotificationsToDisplay().then((value) {
      context.read<NotificationState>().setNotifications(value);
    }).catchError((err) {
      AlertHelper.displayErrorAlert(err, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.only(left: 100, right: 100, top: 30)
        : const EdgeInsets.only(left: 10, right: 10, top: 30);
    var isLoading = useState<bool>(false);

    useEffect(() {
      Future.microtask(() {
        isLoading.value = true;
        refresh(context).whenComplete(() => isLoading.value = false);
      });

      return null;
    }, []);
    List<AppNotification> notifications =
        context.select((NotificationState s) => s.notifications);
    return ListView(children: [
      Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Ilmoitukset", style: TextStyle(fontSize: 20)),
                IconButton(
                    onPressed: () {
                      isLoading.value = true;
                      refresh(context)
                          .whenComplete(() => isLoading.value = false);
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                NotificationList(notifications: notifications),
                isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.only(top: 30), child: AppSpinner())
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
