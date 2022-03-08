import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/main/components/triplocation_info.dart';

class DrawerSingleLocation extends HookWidget {
  DrawerSingleLocation({Key? key, required this.location}) : super(key: key);
  final TripLocation location;
  final TripLocationApi locationApi = TripLocationApi();

  @override
  Widget build(BuildContext context) {
    //var loading = useState<bool>(true);
    TripLocationState tState = context.watch<TripLocationState>();
    var currentLocation = useState<TripLocation?>(null);
    useEffect(() {
      locationApi.getSingleLocation(location.id).then((res) {
        currentLocation.value = res;
      }).catchError((error) {
        AlertHelper.displayErrorAlert("Network error!", context);
      });
      return null;
    }, [location.id]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                context.read<TripLocationState>().resetSelectedLocation();
              },
              icon: const Icon(Icons.chevron_left_sharp)),
          IconButton(
            icon: location.isFavourite
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            onPressed: () {
              if (currentLocation.value != null) {
                tState.toggleFavourite(location);
              }
            },
          ),
        ],
      ),
      const Divider(),
      Expanded(
        child: currentLocation.value == null
            ? const AppSpinner()
            : ListView(
                controller: ScrollController(),
                children: [TriplocationInfo(location: currentLocation.value!)],
              ),
      )
    ]);
  }
}
