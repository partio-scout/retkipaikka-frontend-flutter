import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/notification_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/notification_api.dart';
import 'package:retkipaikka_flutter/helpers/components/notification_card.dart';

import 'package:retkipaikka_flutter/models/app_notification_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/screens/admin/components/notification_form.dart';

class NotificationBuilderState extends ChangeNotifier {
  AppNotification notification;

  NotificationBuilderState({required this.notification});

  void notify() {
    notifyListeners();
  }
}

class NotificationBuilder extends HookWidget {
  NotificationBuilder({Key? key, this.initialData}) : super(key: key);
  final NotificationApi notificationApi = NotificationApi();
  final AppNotification? initialData;
  final AppNotification defaultData = AppNotification(
      text:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      title: "Ilmoitus",
      displayInFrontPage: false,
      displayInList: false,
      linkText: "Lisätietoa",
      linkUrl: "https://www.google.com/");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            NotificationBuilderState(notification: initialData ?? defaultData),
        builder: (context, widget) {
          return Column(
            children: [
              NotificationCard(
                  notification:
                      context.watch<NotificationBuilderState>().notification),
              const SizedBox(height: 25),
              NotificationForm(
                notification: initialData,
                onSubmit: (data) {
                  if (data["notification_id"] == null) {
                    notificationApi.createNotification(data).then((value) {
                      return notificationApi.getAllNotifications();
                    }).then((value) {
                      AlertHelper.displaySuccessAlert(
                          "Ilmoituksen luonti onnistui!", context);
                      context
                          .read<NotificationState>()
                          .setAdminNotifications(value);
                    }).catchError((err) {
                      AlertHelper.displayErrorAlert(err, context);
                    });
                  } else {
                    notificationApi
                        .editNotification(data["notification_id"], data)
                        .then((value) {
                      return notificationApi.getAllNotifications();
                    }).then((value) {
                      AlertHelper.displaySuccessAlert(
                          "Ilmoituksen muokkaus onnistui!", context, cb: () {
                        Navigator.of(context).pop();
                      });

                      context
                          .read<NotificationState>()
                          .setAdminNotifications(value);
                    }).catchError((err) {
                      AlertHelper.displayErrorAlert(err, context);
                    });
                  }
                },
                onDelete: initialData?.id != null
                    ? (id) {
                        notificationApi
                            .deleteNotification(id.toString())
                            .then((value) {
                          return notificationApi.getAllNotifications();
                        }).then((value) {
                          AlertHelper.displaySuccessAlert(
                              "Ilmoituksen poisto onnistui!", context, cb: () {
                            Navigator.of(context).pop();
                          });

                          context
                              .read<NotificationState>()
                              .setAdminNotifications(value);
                        }).catchError((err) {
                          AlertHelper.displayErrorAlert(err, context);
                        });
                      }
                    : null,
              )
            ],
          );
        });
  }
}
