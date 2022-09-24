import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';

class AbstractFilterDatasource extends DataTableSource {
  final List<AbstractFilter> filters;
  final Function(AbstractFilter) onTap;
  AbstractFilterDatasource({required this.filters, required this.onTap});

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (selected) {
        onTap(filters[index]);
      },
      cells: [
        //DataCell(Text(locations[index].id)),
        DataCell(Text(filters[index].id.toString())),
        DataCell(Text(filters[index].name)),
        DataCell(Text(filters[index].nameSv ?? "-")),
        DataCell(Text(filters[index].nameSmn ?? "-")),
        DataCell(Text(filters[index].nameEn ?? "-")),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => filters.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
