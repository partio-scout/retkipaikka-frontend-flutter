import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_dropdown_button.dart';
import 'package:retkipaikka_flutter/helpers/components/simple_dropdown_button.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/location_map.dart';

class MapHeader extends StatelessWidget with PreferredSizeWidget {
  const MapHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TripLocationState tState = context.watch<TripLocationState>();
    return AppBar(
      leading: IconButton(icon: Icon(Icons.menu),onPressed:(){
        
        tState.drawerButtonClick();
      } ),
      actions: [
        SimpleDropdownButton(
            initialValue: "100",
            dropdownData: ["100", "500", "1000", "Kaikki"],
            focusColor: Theme.of(context).primaryColor,
            bgColor: Theme.of(context).primaryColor,
            onDropdownChange: (value){
              print(value);
            },
            ),
        Padding(
          padding: const EdgeInsets.only(top: 17, right: 20, left: 20),
          child: Text(tState.filteredTriplocations.length.toString()),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}