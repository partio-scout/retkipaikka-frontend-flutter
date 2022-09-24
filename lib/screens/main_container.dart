import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/locales/app_localizations.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/screens/app_drawer.dart';
import 'package:retkipaikka_flutter/screens/app_header.dart';
import 'package:routemaster/routemaster.dart';
import 'package:provider/provider.dart';

class AdminMainContainer extends StatelessWidget {
  const AdminMainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    bool isDesktop = Responsive.isDesktop(context);
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar:  AppHeader(title: "Partion Retkipaikat".t(context)),
        //key:context.read<AppState>().mainScaffoldKey,
        endDrawer: AppDrawer(),
        bottomNavigationBar: TabBar(
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: context.select((AppState s) =>
              s.darkTheme ? null : Theme.of(context).primaryColor),
          physics: const NeverScrollableScrollPhysics(),
          tabs: [
            Tab(
              icon: const Icon(
                Icons.plus_one,
              ),
              text: isDesktop ?  "Uudet retkipaikat".t(context) : null,
            ),
            Tab(
                icon: const Icon(
                  Icons.map_outlined,
                ),
                text: isDesktop ? "Selaa retkipaikkoja".t(context) : null),
            Tab(
                icon: const Icon(
                  Icons.filter_list_alt,
                ),
                text: isDesktop ? "Suodattimet".t(context) : null),
            Tab(
                icon: const Icon(
                  Icons.notifications,
                ),
                text: isDesktop ? "Ilmoitukset".t(context) : null),
            Tab(
                icon: const Icon(
                  Icons.settings,
                ),
                text: isDesktop ? "Asetukset".t(context) : null),
          ],
          controller: tabPage.controller,
        ),
        body: TabBarView(
          controller: tabPage.controller,
          children: [
            for (final stack in tabPage.stacks)
              GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: PageStackNavigator(stack: stack)),
          ],
        ));
  }
}

class MainContainerSinglePage extends StatelessWidget {
  const MainContainerSinglePage({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //key:context.read<AppState>().mainScaffoldKey,
        appBar:  AppHeader(title: "Partion Retkipaikat".t(context)),
        endDrawer: AppDrawer(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: child));
  }
}
