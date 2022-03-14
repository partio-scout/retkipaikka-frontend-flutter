import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/hooks/use_fetch_filters.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/form/location_form.dart';
import 'package:retkipaikka_flutter/screens/main/components/triplocation_info.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class SingleLocationScreen extends HookWidget {
  SingleLocationScreen({Key? key, this.locationId}) : super(key: key);
  final String? locationId;
  final TripLocationApi tripLocationApi = ApiService().triplocationApi;
  @override
  Widget build(BuildContext context) {
    var displayEditState = useState<bool>(false);
    var locationState = useState<TripLocation?>(null);
    useFetchFilters(context);

    useEffect(() {
      if (locationId != null) {
        tripLocationApi.getSingleLocation(locationId!).then((value) {
          if (value != null) {
            locationState.value = value;
          } else {
            AlertHelper.displayErrorAlert("Retkipaikkaa ei löytynyt!", context);
          }
        }).catchError((err) {
          AlertHelper.displayErrorAlert(err, context);
        });
      }
      return null;
    }, []);

    // ignore: unused_local_variable
    FilteringState fState = context.watch<FilteringState>();
    return locationState.value == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(controller: ScrollController(), children: [
              TriplocationInfo(
                location: locationState.value!,
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
                            "Haluatko poistaa retkipaikan?", context,
                            onConfirm: () {
                          Navigator.of(context).pop();
                          tripLocationApi
                              .deleteLocationById(locationState.value!.id)
                              .then((res) {
                            AlertHelper.displaySuccessAlert(
                                "Retkipaikan poisto onnistui!", context,
                                cb: () {
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
                      child: Text("Poista".t(context),
                          style: const TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
              displayEditState.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: LocationForm(
                        initialLocation: locationState.value!,
                        afterFormSave: () {},
                      ),
                    )
                  : const SizedBox()
            ]),
          );
  }
}
