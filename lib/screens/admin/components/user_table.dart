import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/components/base_dialog.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/models/role_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/admin/components/admin_datasource.dart';
import 'package:retkipaikka_flutter/screens/admin/components/user_form.dart';

class UserTable extends HookWidget {
  const UserTable(
      {Key? key,
      required this.tableData,
      required this.title,
      required this.onRefreshClick,
      required this.allRoles})
      : super(key: key);
  final List<AdminUser> tableData;
  final Widget title;
  final Function() onRefreshClick;
  final List<Role> allRoles;
  @override
  Widget build(BuildContext context) {
    var rowsPerPage = useState<int>(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PaginatedDataTable(
            header: title,
            availableRowsPerPage: const [10, 15, 50, 100, 1000],
            rowsPerPage: rowsPerPage.value,
            onRowsPerPageChanged: (rows) {
              if (rows != null) {
                rowsPerPage.value = rows;
              }
            },
            actions: [
              IconButton(
                  onPressed: () {
                    onRefreshClick();
                  },
                  icon: const Icon(Icons.refresh))
            ],
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text("Sähköposti")),
              DataColumn(label: Text("Käyttäjänimi")),
              DataColumn(label: Text("Käyttäjäilmoitukset")),
              DataColumn(label: Text("Retkipaikkailmoitukset")),
              DataColumn(label: Text("Roolit")),
            ],
            source: AdminDatasource(
                data: tableData,
                onTap: (user) {
                  showDialog(
                    context: context,
                    builder: (context) => UserTableDialog(
                      user: user,
                      onRefresh: onRefreshClick,
                      allRoles: allRoles,
                    ),
                  );
                })),
      ],
    );
  }
}

class UserTableDialog extends StatelessWidget {
  UserTableDialog(
      {Key? key,
      required this.user,
      required this.allRoles,
      required this.onRefresh})
      : super(key: key);
  final AdminUser user;
  final UserApi userApi = UserApi();
  final Function() onRefresh;
  final List<Role> allRoles;
  @override
  Widget build(BuildContext context) {
    return BaseDialog(children: [
      const Text(
        "Käyttäjän muokkaus",
        style: TextStyle(fontSize: 20),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: const Text(
            "Jos kirjautuminen on sallittu, käyttäjä pääsee kirjautumaan mutta ei pysty muokkaamaan mitään. Käyttäjällä pitää siis olla aina rooli, jotta pystyy muokkaamaan. HUOM. superadmin saa kaikki mahdolliset oikeudet, admin saa muokkaamisoikeudet retkipaikkoihin ja suodattimiin."),
      ),
      UserForm(
        user: user,
        allRoles: allRoles,
        onSubmit: (data) {
          userApi
              .modifyUser(user.id, data)
              .then((value) {
                AlertHelper.displaySuccessAlert(
                    "Käyttäjän muokkaus onnistui", context, cb: () {
                  Navigator.of(context).pop();
                });
              })
              .then((value) => onRefresh())
              .catchError((err) {
                AlertHelper.displayErrorAlert(err, context);
              });
        },
        onDelete: (uuid) {
          userApi
              .deleteUserById(uuid)
              .then((value) {
                AlertHelper.displaySuccessAlert(
                    "Käyttäjän poisto onnistui", context, cb: () {
                  Navigator.of(context).pop();
                });
              })
              .then((value) => onRefresh())
              .catchError((err) {
                AlertHelper.displayErrorAlert(err, context);
              });
        },
      )
    ]);
  }
}
