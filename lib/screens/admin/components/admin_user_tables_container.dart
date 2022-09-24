import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/models/role_model.dart';
import 'package:retkipaikka_flutter/screens/admin/components/table_title.dart';
import 'package:retkipaikka_flutter/screens/admin/components/user_table.dart';

class AdminUserTablesContainer extends HookWidget {
  AdminUserTablesContainer({Key? key}) : super(key: key);
  final UserApi userApi = ApiService().userApi;

  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(false);
    var currentUsers = useState<List<AdminUser>>([]);
    var newUsers = useState<List<AdminUser>>([]);
    var allRoles = useState<List<Role>>([]);
    useEffect(() {
      Future.microtask(() {
        isLoading.value = true;

        userApi.getAllRoles().then((value) {
          allRoles.value = value;
          return userApi.getAllUsers();
        }).then((value) {
          newUsers.value = value.newUsers;
          currentUsers.value = value.oldUsers;
        }).catchError((err) {
          AlertHelper.displayErrorAlert(err, context);
        }).whenComplete(() => isLoading.value = false);
      });
      return null;
    }, []);

    return Column(
      children: [
        UserTable(
          allRoles: allRoles.value,
          tableData: currentUsers.value,
          title: TableTitle(
              text: "Nykyiset käyttäjät".t(context), isLoading: isLoading.value),
          onRefreshClick: () {
            isLoading.value = true;
            userApi.getAllUsers().then((value) {
              newUsers.value = value.newUsers;
              currentUsers.value = value.oldUsers;
            }).catchError((err) {
              AlertHelper.displayErrorAlert(err, context);
            }).whenComplete(() => isLoading.value = false);
          },
        ),
        const SizedBox(height: 25),
        UserTable(
          allRoles: allRoles.value,
          tableData: newUsers.value,
          title:
              TableTitle(text: "Uudet käyttäjät".t(context), isLoading: isLoading.value),
          onRefreshClick: () {
            isLoading.value = true;
            userApi.getAllUsers().then((value) {
              newUsers.value = value.newUsers;
              currentUsers.value = value.oldUsers;
            }).catchError((err) {
              AlertHelper.displayErrorAlert(err, context);
            }).whenComplete(() => isLoading.value = false);
          },
        )
      ],
    );
  }
}
