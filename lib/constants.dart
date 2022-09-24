import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//192.168.0.3 // use computer if if debugging with real device
//10.0.2.2 // android emulator
const kBaseUrl = "https://retkipaikka-backend.herokuapp.com/api";

enum FilterType { region, municipality, filter, category, noFilter, noCategory }

const Map<String, String> kSupportedLocales = {
  "en": "English",
  "fi": "Finnish",
  "sv": "Swedish",
  "smn": "Saame"
};

const kSuperAdminRoles = ["superadmin"];

FilterType typeToFilterType(String type) {
  switch (type) {
    case "filter":
      return FilterType.filter;
    case "locationtype":
      return FilterType.category;
    case "region":
      return FilterType.region;
    case "municipality":
      return FilterType.municipality;
    default:
      return FilterType.filter;
  }
}

String filterTypetoType(FilterType type) {
  switch (type) {
    case FilterType.filter:
      return "filter";
    case FilterType.category:
      return "locationtype";
    case FilterType.region:
      return "region";
    case FilterType.municipality:
      return "municipality";
    default:
      return "filter";
  }
}

Color getTagColor(FilterType type) {
  switch (type) {
    case FilterType.filter:
      return const Color(0xFF253764);
    case FilterType.category:
      return const Color(0xFF28aae1);
    case FilterType.region:
    case FilterType.municipality:
      return const Color(0xFF1c4257);
    default:
      return const Color(0xFF253764);
  }
}

bool isMobile() {
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
