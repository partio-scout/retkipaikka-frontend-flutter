import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/drawer_location_list.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/drawer_single_location.dart';

class MapDrawer extends StatelessWidget {
  const MapDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TripLocation? selectedLocation = context.select((TripLocationState s)=>s.selectedLocation);
    bool drawerOpen = context.select((TripLocationState s)=>s.drawerOpen);
   

    return drawerOpen == true
        ? Drawer(
            child: selectedLocation == null
                ? const DrawerLocationList()
                : DrawerSingleLocation(location: selectedLocation))
        : const SizedBox();
  }
}
