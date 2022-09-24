import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/base_dialog.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:retkipaikka_flutter/screens/admin/components/location_datasource.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/main/components/form/location_form.dart';
import 'package:retkipaikka_flutter/screens/main/components/triplocation_info.dart';
import 'package:provider/provider.dart';

class LocationTable extends HookWidget {
  const LocationTable(
      {Key? key,
      required this.tableData,
      required this.title,
      required this.onRefreshClick})
      : super(key: key);
  final List<TripLocation> tableData;
  final Widget title;
  final Function() onRefreshClick;
  @override
  Widget build(BuildContext context) {
    var rowsPerPage = useState<int>(10);
    List<AbstractFilter> categories =
        context.select((FilteringState f) => f.allCategoryFilters);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PaginatedDataTable(
            header: title,
            actions: [
              IconButton(
                  onPressed: () {
                    onRefreshClick();
                  },
                  icon: const Icon(Icons.refresh))
            ],
            availableRowsPerPage: const [10, 15, 50, 100, 1000],
            rowsPerPage: rowsPerPage.value,
            onRowsPerPageChanged: (rows) {
              if (rows != null) {
                rowsPerPage.value = rows;
              }
            },
            showCheckboxColumn: false,
            columns:  [
              DataColumn(label: Text("Nimi".t(context))),
              DataColumn(label: Text("Kunta".t(context))),
              DataColumn(label: Text("Maakunta".t(context))),
              DataColumn(label: Text("Tyyppi".t(context))),
              DataColumn(label: Text("Omistaja".t(context))),
            ],
            source: LocationDatasource(
                categories: categories,
                locations: tableData,
                context:context,
                onTap: (location) {
                  showDialog(
                    context: context,
                    builder: (context) => LocationTableDialog(
                      location: location,
                    ),
                  );
                })),
      ],
    );
  }
}

class LocationTableDialog extends HookWidget {
  LocationTableDialog({Key? key, required this.location}) : super(key: key);
  final TripLocation location;
  final TripLocationApi tripLocationApi = ApiService().triplocationApi;

  Future<void> refreshAll(BuildContext context) async {
    List<TripLocation> acceptedLocs =
        await tripLocationApi.getAcceptedLocations(limitedFields: false);
    List<TripLocation> newLocs = await tripLocationApi.getNewLocations();

    context.read<TripLocationState>().setNewAndAccepted(acceptedLocs, newLocs);
    return;
  }

  @override
  Widget build(BuildContext context) {
    var displayEditState = useState<bool>(false);

    return BaseDialog(children: [
      TriplocationInfo(
        location: location,
        displayEditorName: true,
        displayMapButton: false,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                displayEditState.value = !displayEditState.value;
              },
              child: Text(
                "Muokkaa".t(context),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            MaterialButton(
              color: Colors.red,
              onPressed: () {
                AlertHelper.displayConfirmAlert(
                    "Haluatko poistaa retkipaikan?", context, onConfirm: () {
                  Navigator.of(context).pop();
                  tripLocationApi.deleteLocationById(location.id).then((res) {
                    return refreshAll(context);
                  }).then((res) {
                    AlertHelper.displaySuccessAlert(
                        "Retkipaikan poisto onnistui!", context, cb: () {
                      Navigator.of(context).pop();
                    });
                  }).catchError((err) {
                    //Navigator.of(context).pop();
                    AlertHelper.displayErrorAlert(err, context);
                  });
                }, onCancel: () {
                  Navigator.of(context).pop();
                });
              },
              child:
                   Text("Poista".t(context), style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
      displayEditState.value
          ? Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: LocationForm(
                initialLocation: location,
                afterFormSave: () {
                  refreshAll(context)
                      .then((value) => Navigator.of(context).pop());
                },
              ),
            )
          : const SizedBox()
    ]);
  }
}
