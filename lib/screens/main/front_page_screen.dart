import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return ListView(
        physics: context.watch<AppState>().scrollEnabled
            ? null
            : const NeverScrollableScrollPhysics(),
        children: [
          const TitleImage(),
          FilteringComponent(),
          Padding(
            padding: padding,
            child: MapContainer(),
          ),
          // Padding(
          //   padding: padding,
          //   child: LocationForm(),
          // )
        ]);
  }
}
