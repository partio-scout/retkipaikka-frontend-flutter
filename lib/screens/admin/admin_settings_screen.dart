import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/screens/admin/components/new_location_notifications.dart';
import 'package:retkipaikka_flutter/screens/admin/components/new_user_notifications.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/admin/components/user_info.dart';
import 'package:retkipaikka_flutter/screens/admin/components/user_table.dart';

class AdminSettingsScreen extends HookWidget {
  const AdminSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.only(left: 100, right: 100, top: 20)
        : const EdgeInsets.only(left: 10, right: 10, top: 20);
    return SingleChildScrollView(
      padding: padding,
      child: Column(children: [
        NewLocationNotifications(),
        const SizedBox(height: 25),
        NewUserNotifications(),
        const SizedBox(height: 25),
        UserInfo(),
        const SizedBox(height: 25),
        UserTable(),
        const SizedBox(height: 25),
        UserTable()
      ]),
    );
  }
}
