import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/screens/admin/components/location_table.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/admin/components/table_title.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/filtering_component.dart';

class AdminLocationsScreen extends HookWidget {
  AdminLocationsScreen({Key? key, required this.displayOnlyNew})
      : super(key: key);
  final bool displayOnlyNew;
  final TripLocationApi tripLocationApi = ApiService().triplocationApi;

  Future<void> refreshNewLocations(BuildContext context) {
    return tripLocationApi.getNewLocations().then((res) {
      context.read<TripLocationState>().setNewLocations(res);
    }).catchError((err) {
      AlertHelper.displayErrorAlert(err, context);
    });
  }

  Future<void> refreshAcceptedLocations(BuildContext context) {
    return tripLocationApi
        .getAcceptedLocations(limitedFields: false)
        .then((res) {
      context.read<TripLocationState>().setLocations(res);
    }).catchError((err) {
      AlertHelper.displayErrorAlert(err, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    TripLocationState tState = context.watch<TripLocationState>();

    var isLoading = useState<bool>(false);
    useEffect(() {
      if (displayOnlyNew) {
        Future.microtask(() {
          isLoading.value = true;
          refreshNewLocations(context)
              .whenComplete(() => isLoading.value = false);
        });
      } else {
        if (!tState.adminLocationsInitialLoad) {
          Future.microtask(() {
            isLoading.value = true;
            refreshAcceptedLocations(context).whenComplete(() {
              tState.adminLocationsInitialLoad = true;
              isLoading.value = false;
            });
          });
        }
      }
      return null;
    }, []);

    EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.only(left: 100, right: 100, top: 20)
        : const EdgeInsets.only(left: 10, right: 10, top: 20);

    return ListView(
      children: [
        Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayOnlyNew? const SizedBox() :FilteringComponent(
                backgroundColor: Colors.white,
              ),
              LocationTable(
                onRefreshClick: () {
                  if (displayOnlyNew) {
                    isLoading.value = true;
                    refreshNewLocations(context)
                        .whenComplete(() => isLoading.value = false);
                  } else {
                    isLoading.value = true;
                    refreshAcceptedLocations(context)
                        .whenComplete(() => isLoading.value = false);
                  }
                },
                title: displayOnlyNew
                    ? TableTitle(
                        text: "Uudet retkipaikat".t(context), isLoading: isLoading.value)
                    : TableTitle(
                        text: "Retkipaikat".t(context), isLoading: isLoading.value),
                tableData: displayOnlyNew
                    ? tState.newLocations
                    : tState.filteredTriplocations,
              )
            ],
          ),
        ),
      ],
    );
  }
}
