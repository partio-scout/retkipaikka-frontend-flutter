import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/filtering_api.dart';
import 'package:retkipaikka_flutter/helpers/components/base_dialog.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/screens/admin/components/abstract_filter_datasource.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/admin/components/filter_form.dart';

class FilterTable extends HookWidget {
  const FilterTable(
      {Key? key,
      required this.tableData,
      required this.isSuperAdmin,
      required this.title,
      required this.onRefreshClick})
      : super(key: key);
  final List<AbstractFilter> tableData;
  final Widget title;
  final Function() onRefreshClick;
  final bool isSuperAdmin;
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
              DataColumn(label: Text("#")),
              DataColumn(label: Text("Nimi")),
              DataColumn(label: Text("SV")),
              DataColumn(label: Text("SMN")),
              DataColumn(label: Text("EN")),
            ],
            source: AbstractFilterDatasource(
                filters: tableData,
                onTap: (filter) {
                  if (isSuperAdmin) {
                    showDialog(
                      context: context,
                      builder: (context) => FilterTableDialog(
                          filter: filter, onRefresh: onRefreshClick),
                    );
                  }
                })),
      ],
    );
  }
}

class FilterTableDialog extends StatelessWidget {
  FilterTableDialog({Key? key, required this.filter, required this.onRefresh})
      : super(key: key);
  final AbstractFilter filter;
  final FilteringApi filteringApi = FilteringApi();
  final Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return BaseDialog(children: [
      FilterForm(
        resetAfterSubmit: false,
        title: "Muokkaaminen",
        initialFilter: filter,
        onSubmit: (data) {
          Map<String, dynamic> formData = Map.from(data);
          if (filter.type == kfilterType.filter) {
            formData["filter_id"] = filter.id;
            filteringApi.updateFilter(formData, filter.id).then((value) {
              AlertHelper.displaySuccessAlert(
                  "Suodattimen muokkaus onnistui!", context, cb: () {
                onRefresh();
                Navigator.of(context).pop();
              });
            }).catchError((err) {
              AlertHelper.displayErrorAlert(err, context);
            });
          } else if (filter.type == kfilterType.category) {
            formData["category_id"] = filter.id;
            filteringApi.updateCategory(formData, filter.id).then((value) {
              AlertHelper.displaySuccessAlert(
                  "Kategorian muokkaus onnistui!", context, cb: () {
                onRefresh();
                Navigator.of(context).pop();
              });
            }).catchError((err) {
              AlertHelper.displayErrorAlert(err, context);
            });
          }
        },
        onDelete: (id) {
          if (filter.type == kfilterType.filter) {
            filteringApi.deleteFilter(id).then((value) {
              AlertHelper.displaySuccessAlert(
                  "Suodattimen poisto onnistui!", context, cb: () {
                onRefresh();
                Navigator.of(context).pop();
              });
            }).catchError((err) {
              AlertHelper.displayErrorAlert(err, context);
            });
          } else if (filter.type == kfilterType.category) {
            filteringApi.deleteCategory(id).then((value) {
              AlertHelper.displaySuccessAlert(
                  "Kategorian poisto onnistui!", context, cb: () {
                onRefresh();
                Navigator.of(context).pop();
              });
            }).catchError((err) {
              AlertHelper.displayErrorAlert(err, context);
            });
          }
        },
      ),
    ]);
  }
}
