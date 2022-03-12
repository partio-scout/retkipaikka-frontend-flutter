import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/location_map.dart'
    deferred as location_map;
import 'package:retkipaikka_flutter/screens/main/components/map/map_drawer.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/map_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MapContainer extends HookWidget {
  MapContainer({Key? key}) : super(key: key);
  final TripLocationApi triplocationApi = ApiService().triplocationApi;
  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(false);
    useEffect(() {
      Future.microtask(() {
        TripLocationState state = context.read<TripLocationState>();
        if (state.allTripLocations.isEmpty) {
          isLoading.value = true;
          triplocationApi.getAcceptedLocations().then((res) {
            state.setLocations(res);
          }).catchError((err) {
            if (kDebugMode) {
              print("FETCHING TRIPLOCATIONS ERROR");
            }
            AlertHelper.displayErrorAlert(err, context);
          }).whenComplete(() => isLoading.value = false);
        }
      });
      return null;
    }, []);

    double windowHeight = MediaQuery.of(context).size.height - 100;
    bool isDesktop = Responsive.isDesktop(context);
    windowHeight = isDesktop ? windowHeight : windowHeight * 0.85;
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
            height: windowHeight,
            child: Stack(
              children: [
                Scaffold(
                    drawerScrimColor: Colors.transparent,
                    appBar: const MapHeader(),
                    body: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FutureBuilder(
                            future: location_map.loadLibrary(),
                            builder: (context, snapshot) {
                              return location_map.LocationMap();
                            },
                          ),
                        ),
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
