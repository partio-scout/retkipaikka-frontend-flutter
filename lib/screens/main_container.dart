import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/screens/app_drawer.dart';
import 'package:retkipaikka_flutter/screens/app_header.dart';
import 'package:retkipaikka_flutter/screens/main/front_page_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'package:provider/provider.dart';
class AdminMainContainer extends StatelessWidget {
  const AdminMainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    bool isDesktop = Responsive.isDesktop(context);
    return Scaffold(
        appBar: const AppHeader(title: "Partion Retkipaikat"),
        //key:context.read<AppState>().mainScaffoldKey,
        endDrawer:  AppDrawer(),
        bottomNavigationBar: TabBar(
        labelColor: Theme.of(context).primaryColor, 
        physics: const NeverScrollableScrollPhysics(),
        tabs:  [
          Tab(icon: const Icon(Icons.plus_one,),text: isDesktop?"Uudet retkipaikat":null ,),
          Tab(icon: const Icon(Icons.map_outlined,),text:isDesktop?"Selaa retkipaikkoja":null),
          Tab(icon: const Icon(Icons.filter_list_alt,),text:isDesktop?"Suodattimet":null),
          Tab(icon: const Icon(Icons.notifications,),text:isDesktop?"Ilmoitukset":null),
          Tab(icon: const Icon(Icons.settings,),text: isDesktop?"Asetukset":null),
        ],
        controller: tabPage.controller,
        
        ),
        body: TabBarView(
          controller: tabPage.controller,
          children: [
            for (final stack in tabPage.stacks)
              PageStackNavigator(stack: stack),
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
        appBar:AppHeader(title: "Partion Retkipaikat"),
        endDrawer:  AppDrawer(),
         body: child);
  }
}
