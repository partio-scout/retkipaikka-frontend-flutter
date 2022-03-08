import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/helpers/api/base_api.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class FormParser {
  static Map<String, dynamic>? afterLocationFormSubmit(
      Map<String, dynamic> rawFormData, BuildContext context) {
    Map<String, dynamic> dataCpy = Map.from(rawFormData);
    List<String> splittedCoords = (dataCpy["location_geo"] ?? []).split(",");
    if (splittedCoords.length == 2) {
      var geoObj = {"lat": splittedCoords[0], "lng": splittedCoords[1]};
      dataCpy["location_geo"] = geoObj;
    } else {
      if (kDebugMode) {
        print("GEO IS NOT VALID");
      }
      return null;
    }
    FilteringState state = context.read<FilteringState>();

    AbstractFilter? municipality = state.allMunicipalities.firstWhereOrNull(
        (element) => element.name == dataCpy["location_area"]);
    int? municipalityId;
    int regionId = -1;
    if (municipality != null) {
      municipalityId = municipality.id;
      regionId = municipality.parentId;
    } else {
      AbstractFilter? region = state.allRegions.firstWhereOrNull(
          (element) => element.name == dataCpy["location_area"]);
      if (region != null) {
        regionId = region.id;
      }
    }

    if (regionId == -1) {
      if (kDebugMode) {
        print("REGION ID IS NOT VALID");
      }
      return null;
    }
    dataCpy.remove("location_area");
    dataCpy["location_municipality"] = municipalityId;
    dataCpy["location_region"] = regionId;
    return dataCpy;
  }

  static List<XFile> imageStringsToXFile(
      List<String> images, String locationId) {
    List<XFile> imgs = [];

    for (var image in images) {
      var path =
          BaseApi.baseUrl + "/Images/" + locationId + "/download/" + image;
      imgs.add(XFile(path, name: image));
    }

    return imgs;
  }
}
