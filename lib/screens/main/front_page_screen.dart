import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/notification_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';

import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';
import 'package:retkipaikka_flutter/routes.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/filtering_component.dart';
import 'package:retkipaikka_flutter/screens/main/components/form/location_form.dart' deferred as location_form;
import 'package:retkipaikka_flutter/screens/main/components/map/map_container.dart';
import 'package:retkipaikka_flutter/screens/main/components/title_image.dart';

import 'package:routemaster/routemaster.dart';
import 'package:flash/flash.dart';

class FrontPageScreen extends HookWidget {
  const FrontPageScreen({
    Key? key,
  }) : super(key: key);

  void saveNotificationSeen(String id) {
    SharedPreferencesHelper.saveNotificationId(id);
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    EdgeInsets padding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 20);

    bool scrollEnabled = context.select((AppState a) => a.scrollEnabled);
    ScrollController cont = context.select((AppState a) => a.scrollController);
    useEffect(() {
      Future.microtask(() async {
        NotificationApi notificationApi = ApiService().notificationApi;

        notificationApi.getNotificationForFrontpage().then((value) {
          if (value != null) {
            showFlash(
              context: context,
              duration: const Duration(seconds: 10),
              builder: (_, controller) {
                return Flash(
                  controller: controller,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,

                  boxShadows: [const BoxShadow(blurRadius: 4)],
                  barrierBlur: 3.0,
                  //barrierColor: Colors.black38,
                  barrierDismissible: true,
                  behavior: FlashBehavior.floating,
                  position: FlashPosition.top,
                  child: FlashBar(
                    title: Text(value.getTranslatedTitle(context)),
                    content: Text(value.getTranslatedText(context)),
                    //showProgressIndicator: false,
                    actions: [
                      InkWell(
                        child: const Text("..."),
                        onTap: () {
                          controller.dismiss();
                          Routemaster.of(context)
                              .push(UserRoutes.notifications);
                        },
                      )
                    ],
                    primaryAction: TextButton(
                      onPressed: () => controller.dismiss(),
                      child: Text('Ok',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                );
              },
            ).then((_) {
              SharedPreferencesHelper.saveNotificationId(value.id.toString());
            });
          }
        }).catchError((err) {
          AlertHelper.displayErrorAlert(err, context);
        });
      });
      return null;
    }, []);
    return ListView(
        controller: cont,
        physics: scrollEnabled ? null : const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleImage(),
              FilteringComponent(),
              Padding(
                padding: padding,
                child: MapContainer(),
              ),
              //CustomImagePicker(),
              Padding(
                padding: padding,
                child: ListTileTheme(
                  dense: true, // Reduces height
                  child: ExpansionTile(
                      //collapsedIconColor: Colors.black,
                      iconColor: Theme.of(context).textTheme.bodyText1?.color,
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Ilmoita Retkipaikka!".t(context),
                            style: const TextStyle(fontSize: 25)),
                      ),

                      //collapsedBackgroundColor: Colors.white,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: FutureBuilder(future: location_form.loadLibrary(), builder: (context, snapshot) {
                            return location_form.LocationForm();
                          }),
                        )
                      ]),
                ),
              )
            ],
          )
        ]);
  }
}
