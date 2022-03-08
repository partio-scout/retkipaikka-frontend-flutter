import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';

import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/helpers/components/image_slider.dart';

class TriplocationInfo extends StatelessWidget {
  const TriplocationInfo(
      {Key? key,
      required this.location,
      this.displayMapButton = true,
      this.displayEditorName = false})
      : super(key: key);
  final TripLocation location;
  final bool displayMapButton;
  final bool displayEditorName;

  List<Widget> textInfoCombo(String title, String? info) {
    return [
      Text(title, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 5),
      Text(info ?? "-"),
      const SizedBox(
        height: 15,
      )
    ];
  }

  List<Widget> getFilters(TripLocation location, BuildContext context) {
    List<Widget> returnList = [];
    FilteringState state = context.read<FilteringState>();
    for (var filter in location.filters) {
      String? name = state.getFilterNameById(filter);
      if (name != null) {
        returnList.addAll([Text(name), const SizedBox(height: 5)]);
      }
    }

    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...textInfoCombo("Nimi:", location.name),
          ...textInfoCombo("Kuvaus:", location.description),
          ...textInfoCombo("Kunta:", location.municipality),
          ...textInfoCombo("Maakunta:", location.region),
          ...textInfoCombo("Tyyppi",
              context.read<FilteringState>().getCategoryForLocation(location)),
          const Text("Ominaisuudet:", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 5),
          ...getFilters(location, context),
          ...textInfoCombo("Omistaja:", location.owner),
          ...textInfoCombo("Hinnoittelu:", location.pricing),
          ...textInfoCombo("Verkkosivu:", location.website),
          ...textInfoCombo("Puhelin:", location.phone),
          ...textInfoCombo("Sähköposti:", location.mail),
          ...textInfoCombo("Lisätty:", location.createdAtParsed()),
          ...textInfoCombo("Muokattu:", location.updatedAtParsed()),
          if (displayEditorName)
            ...textInfoCombo("Viimeksi muokannut:", location.editorName),
          displayMapButton
              ? Center(
                  child: TextButton(
                  child: const Text("Näytä kartalla"),
                  onPressed: () {
                    TripLocationState state = context.read<TripLocationState>();
                    //state.closeDrawer();
                    state.centerMapToLocation(location);
                  },
                ))
              : const SizedBox(),
          const SizedBox(height: 15),
          location.images.isNotEmpty
              ? Center(
                  child: TextButton(
                  child: const Text("Näytä kuvat"),
                  onPressed: () {
                    TripLocationState state = context.read<TripLocationState>();
                    List<String> images =
                        state.parseLocationImages(location.images, location.id);

                    showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: ImageSlider(images: images),
                      ),
                    );
                  },
                ))
              : const SizedBox()
        ],
      ),
    );
  }
}
