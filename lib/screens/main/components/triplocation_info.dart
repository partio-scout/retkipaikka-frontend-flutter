import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';

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

  List<Widget> textInfoCombo(String title, String? info,BuildContext context) {
    return [
      Text(title.t(context) +":", style: const TextStyle(fontSize: 20)),
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
      AbstractFilter? name = state.getFilterById(filter);
      if (name != null) {
        returnList.addAll([Text(name.getTranslatedName(context)), const SizedBox(height: 5)]);
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
          ...textInfoCombo("Nimi", location.name,context),
          ...textInfoCombo("Kuvaus", location.description,context),
          ...textInfoCombo("Kunta", location.municipality,context),
          ...textInfoCombo("Maakunta", location.region,context),
          ...textInfoCombo("Tyyppi",
              context.read<FilteringState>().getCategoryForLocation(location)?.getTranslatedName(context),context),
          const Text("Ominaisuudet", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 5),
          ...getFilters(location, context),
          ...textInfoCombo("Omistaja", location.owner,context),
          ...textInfoCombo("Hinnoittelu", location.pricing,context),
          ...textInfoCombo("Verkkosivu", location.website,context),
          ...textInfoCombo("Puhelin", location.phone,context),
          ...textInfoCombo("Sähköposti", location.mail,context),
          ...textInfoCombo("Lisätty", location.createdAtParsed(),context),
          ...textInfoCombo("Muokattu", location.updatedAtParsed(),context),
          if (displayEditorName)
            ...textInfoCombo("Viimeksi muokannut", location.editorName,context),
          displayMapButton
              ? Center(
                  child: TextButton(
                  child:  Text("Näytä kartalla".t(context)),
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
                  child:  Text("Näytä kuvat".t(context)),
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
