import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/location_map.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/map_drawer.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/map_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MapContainer extends HookWidget {
  MapContainer({Key? key}) : super(key: key);
  final TripLocationApi triplocationApi = TripLocationApi();
  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    var isLoading = useState<bool>(false);
    useEffect(() {
      Future.microtask(() {
        TripLocationState state = context.read<TripLocationState>();
        if (state.allTripLocations.isEmpty) {
          isLoading.value = true;
          triplocationApi.getAcceptedLocations().then((res) {
            state.setLocations(res);
          }).catchError((err) {
            print("FETCHING TRIPLOCATIONS ERROR");
            AlertHelper.displayErrorAlert("Network error!", context);
          }).whenComplete(() => isLoading.value = false);
        }
      });
    }, []);
    return MouseRegion(
      onEnter: (event) {
        AppState state = context.read<AppState>();
        if (state.scrollEnabled) {
          state.setScroll(false);
        }
      },
      onExit: (event) {
        AppState state = context.read<AppState>();
        if (!state.scrollEnabled) {
          state.setScroll(true);
        }
      },
      child: IgnorePointer(
        ignoring: isLoading.value,
        child: SizedBox(
            height: isDesktop ? 800 : 600,
            child: Stack(
              children: [
                Scaffold(
                    drawerScrimColor: Colors.transparent,
                    appBar: const MapHeader(),
                    body: Stack(
                      children: [
                        SizedBox(width: double.infinity, child: LocationMap()),
                        const MapDrawer(),
                        //isLoading.value?const AppSpinner():const SizedBox(),
                      ],
                    )),
                if (isLoading.value) ...[
                  Container(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const AppSpinner()
                ]
              ],
            )),
      ),
    );
  }
}
