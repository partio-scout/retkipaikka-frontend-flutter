import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/routes.dart';
import 'package:routemaster/routemaster.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget with PreferredSizeWidget {
  const AppHeader({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: InkWell(onTap: (){
        Routemaster.of(context).push(UserRoutes.locations);
      }, child: Text(title)),
      
      actions: [
        IconButton(onPressed:(){
          context.read<AppState>().openDrawer(context);
        }, icon: const Icon(Icons.menu))
        // MaterialButton(
        //     child: Text("Kirjaudu",style:TextStyle(color: Colors.white)),
        //     onPressed: () {
        //       Routemaster.of(context).push(UserRoutes.login);
        //     })
      ],
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
