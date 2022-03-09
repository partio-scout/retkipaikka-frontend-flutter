import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/hooks/use_check_user_has_rights.dart';
import 'package:retkipaikka_flutter/helpers/hooks/use_fetch_filters.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/screens/admin/components/admin_user_tables_container.dart';
import 'package:retkipaikka_flutter/screens/admin/components/new_location_notifications.dart';
import 'package:retkipaikka_flutter/screens/admin/components/new_user_notifications.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/admin/components/user_info.dart';
import 'package:provider/provider.dart';

class AdminSettingsScreen extends HookWidget {
  const AdminSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.only(left: 100, right: 100, top: 40)
        : const EdgeInsets.only(left: 10, right: 10, top: 40);

    AdminUser? user = context.select((AppState s) => s.currentUser);
    useFetchFilters(context);
    bool isSuperAdmin = useCheckHasUserRights(context);

    return ListView(
      children: [
        Padding(
          padding: padding,
          child: Column(children: [
            NewLocationNotifications(user: user),
            const SizedBox(height: 25),
            NewUserNotifications(user: user),
            const SizedBox(height: 25),
            UserInfo(
              user: user,
            ),
            const SizedBox(height: 25),
            if (isSuperAdmin) AdminUserTablesContainer()
          ]),
        ),
      ],
    );
  }
}
