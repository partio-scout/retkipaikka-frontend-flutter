import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';

class DrawerLocationList extends StatelessWidget {
  const DrawerLocationList({Key? key}) : super(key: key);

  List<Widget> buildByCategory(List<TripLocation> categoryLocations,
      String categoryName, BuildContext context) {
    List<Widget> tiles = [];
    tiles.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(categoryName, style: const TextStyle(fontSize: 20)),
    ));
    for (var location in categoryLocations) {
      tiles.add(ListTile(
        title: Text(location.name),
        onTap: () {
          context.read<TripLocationState>().setSelectedLocation(location);
        },
      ));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    TripLocationState tState = context.watch<TripLocationState>();
    List<AbstractFilter> categories =
        context.read<FilteringState>().allCategoryFilters;

    List<TripLocation> favourites = tState.filteredTriplocations.where((element) => element.isFavourite).toList();
    return ListView(
      controller: ScrollController(),
      children: [
      SizedBox(
        height: 10,
      ),
      if(favourites.isNotEmpty) ...[Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text("Suosikit", style: const TextStyle(fontSize: 20)),
      ),
      ...favourites.map((location) {
        return ListTile(
          title: Text(location.name),
          onTap: () {
            context.read<TripLocationState>().setSelectedLocation(location);
          },
        );
      }),
       Divider(),
      SizedBox(
        height: 10,
      )],
      ...categories
          .map((category) {
            List<Widget> returnList = [];
            List<TripLocation> categoryLocations = tState.filteredTriplocations
                .where((element) => element.category == category.id)
                .toList();
            if (categoryLocations.isNotEmpty) {
              returnList.addAll(
                  buildByCategory(categoryLocations, category.name, context));
            }
            return returnList;
          })
          .expand((element) => element)
          .toList()
    ]);
  }
}
