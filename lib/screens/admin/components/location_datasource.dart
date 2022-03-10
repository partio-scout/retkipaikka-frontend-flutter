import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:collection/collection.dart';
class LocationDatasource extends DataTableSource {
  final List<TripLocation> locations;
  final Function(TripLocation) onTap;
  final List<AbstractFilter> categories;
  final BuildContext context;
  LocationDatasource({required this.locations, required this.onTap,required this.categories,required this.context});

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
        DataCell(Text(getCategoryNameById(locations[index].category))),
        DataCell(Text(locations[index].owner ?? "-")),
      ],
    );
  }
  String getCategoryNameById(int id) {
   
    AbstractFilter? category =
        categories.firstWhereOrNull((element) => element.id == id);
    return category?.getTranslatedName(context) ?? "-";
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
