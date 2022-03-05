import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';

class LocationDatasource extends DataTableSource {
  final List<TripLocation> locations;
  final Function(TripLocation) onTap;
  LocationDatasource({required this.locations, required this.onTap});

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (selected) {
        onTap(locations[index]);
      },
      cells: [
        //DataCell(Text(locations[index].id)),
        DataCell(Text(locations[index].name)),
        DataCell(Text(locations[index].municipality ?? "-")),
        DataCell(Text(locations[index].region)),
        DataCell(Text(locations[index].category.toString())),
        DataCell(Text(locations[index].owner ?? "-")),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => locations.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
