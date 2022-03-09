import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';

import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/screens/main/components/filtering/filtering_component.dart';
import 'package:retkipaikka_flutter/screens/main/components/form/location_form.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/map_container.dart';
import 'package:retkipaikka_flutter/screens/main/components/title_image.dart';

class FrontPageScreen extends HookWidget {
  const FrontPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    EdgeInsets padding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 20);

    AppState state = context.watch<AppState>();
    return ListView(
        controller: state.scrollController,
        physics:
            state.scrollEnabled ? null : const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleImage(),
              FilteringComponent(),
              Padding(
                padding: padding,
                child: MapContainer(),
              ),
              //CustomImagePicker(),
              Padding(
                padding: padding,
                child: ListTileTheme(
                  dense: true, // Reduces height
                  child: ExpansionTile(
                      //collapsedIconColor: Colors.black,
                      iconColor: Theme.of(context).textTheme.bodyText1?.color,
                      title: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Ilmoita Retkipaikka!",
                            style: TextStyle(fontSize: 25)),
                      ),
    
                      //collapsedBackgroundColor: Colors.white,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: LocationForm(),
                        )
                      ]),
                ),
              )
            ],
          )
        ]);
  }
}
