import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';

class AdminDatasource extends DataTableSource {
  final List<AdminUser> data;
  final Function(AdminUser) onTap;
  AdminDatasource({required this.data, required this.onTap});

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (selected) {
        onTap(data[index]);
      },
      cells: [
        //DataCell(Text(locations[index].id)),
        DataCell(Text(data[index].email)),
        DataCell(Text(data[index].username)),
        DataCell(Text(notificationToStr(data[index].userNotifications))),
        DataCell(Text(notificationToStr(data[index].notifications))),
        DataCell(
            Text(data[index].roles.map((e) => e["name"]).toList().join(", "))),
      ],
    );
  }

  String notificationToStr(String noti) {
    switch (noti) {
      case "none":
        return "Ei mitään";
      case "all":
        return "Kaikki";
      case "select":
        return "Valitut maakunnat";
      default:
        return "-";
    }
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
