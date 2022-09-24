import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/routes.dart';

import 'package:routemaster/routemaster.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);
  final UserApi userApi = ApiService().userApi;
  @override
  Widget build(BuildContext context) {
    AppState aState = context.watch<AppState>();

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(25),
              children: <Widget>[
                const SizedBox(height: 20),
                if (aState.isLoggedIn && aState.currentUser != null) ...[
                  FittedBox(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              aState.currentUser!.email,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 5),
                            Text(aState.currentUser!.username),
                            const SizedBox(height: 5),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Divider(),
                  const SizedBox(height: 15),
                ] else
                  const SizedBox(),
                if (aState.isLoggedIn) ...[
                  generateListTile(
                      context: context,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      leadingIcon: Icons.map_outlined,
                      titleText: "Retkipaikat".t(context),
                      onTap: () {
                        Routemaster.of(context).push(UserRoutes.locations);
                        aState.closeDrawer(context);
                      }),
                  generateListTile(
                      context: context,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      leadingIcon: Icons.settings_outlined,
                      titleText: "Hallinta".t(context),
                      onTap: () {
                        Routemaster.of(context).push(AdminRoutes.adminNew);
                        aState.closeDrawer(context);
                      })
                ] else ...[
                  generateListTile(
                      context: context,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      leadingIcon: Icons.login,
                      titleText: "Kirjaudu".t(context),
                      onTap: () {
                        Routemaster.of(context).push(UserRoutes.login);
                        aState.closeDrawer(context);
                      }),
                ],
                generateListTile(
                    context: context,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    leadingIcon: Icons.notifications_outlined,
                    titleText: "Ilmoitukset".t(context),
                    onTap: () {
                      Routemaster.of(context).push(UserRoutes.notifications);
                      aState.closeDrawer(context);
                    }),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: kSupportedLocales.keys.map((locale){
                      return  InkWell(
                        child: Text(locale, style: TextStyle(
                          fontWeight:aState.appLocale.languageCode == locale? FontWeight.bold:null,
                          color:  aState.appLocale.languageCode == locale? Theme.of(context).colorScheme.primary:null)),
                        onTap: () {
                          aState.setLocale(locale);
                        
                        },
                      );
                    }).toList()

                    
                    
                  ),
                  const SizedBox(height: 15,),
                  //const Divider(),
                  generateListTile(
                      context: context,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      titleText: "Tumma teema".t(context),
                      // use Sizedbox because switch has some built in padding
                      leadingWidget: SizedBox(
                          width: 35,
                          child: Switch(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              //activeTrackColor:
                              //  Theme.of(context).primaryColor,
                              value: aState.darkTheme,
                              onChanged: (bool value) {
                                aState.setDarkTheme(!aState.darkTheme);
                              }))),
                  aState.isLoggedIn && aState.currentUser != null
                      ? generateListTile(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          leadingIcon: Icons.logout,
                          titleText: "Kirjaudu ulos".t(context),
                          context: context,
                          onTap: () async {
                            userApi.logout(aState.currentUser).then((res) {
                              return aState.handleAfterLogout();
                            }).then((res) {
                              // BuildContext sContext = Scaffold.of(context).context;
                              AlertHelper.displaySuccessAlert(
                                  "Uloskirjautuminen onnistui!", context,
                                  cb: () {
                                Routemaster.of(context)
                                    .push(UserRoutes.locations);
                              });
                            }).catchError((err) {
                              AlertHelper.displayErrorAlert(err, context);
                            });

                            //aState.closeDrawer(context);
                          })
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ListTile generateListTile(
    {EdgeInsetsGeometry? padding,
    IconData? leadingIcon,
    String titleText = "",
    Function()? onTap,
    Widget? leadingWidget,
    required BuildContext context}) {
  Widget leadingItem = Icon(leadingIcon);
  if (leadingWidget != null) {
    leadingItem = leadingWidget;
  }
  return (ListTile(
    contentPadding: padding,
    leading: leadingItem,
    title: Text(
      titleText,
      style: const TextStyle(fontSize: 16),
    ),
    //hoverColor: Theme.of(context).primaryColor,
    onTap: onTap,
  ));
}
