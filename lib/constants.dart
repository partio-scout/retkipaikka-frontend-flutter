import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//192.168.0.3 // use computer if if debugging with real device
//10.0.2.2 // android emulator
const kBaseUrl = "https://retkipaikka-backend.herokuapp.com/api";

enum kfilterType {
  region,
  municipality,
  filter,
  category,
  noFilter,
  noCategory
}

const Map<String, String> kSupportedLocales = {
  "en": "English",
  "fi": "Finnish",
  "sv": "Swedish",
  "smn": "Saame"
};

const kSuperAdminRoles = ["superadmin"];

kfilterType typeToFilterType(String type) {
  switch (type) {
    case "filter":
      return kfilterType.filter;
    case "locationtype":
      return kfilterType.category;
    case "region":
      return kfilterType.region;
    case "municipality":
      return kfilterType.municipality;
    default:
      return kfilterType.filter;
  }
}

String filterTypetoType(kfilterType type) {
  switch (type) {
    case kfilterType.filter:
      return "filter";
    case kfilterType.category:
      return "locationtype";
    case kfilterType.region:
      return "region";
    case kfilterType.municipality:
      return "municipality";
    default:
      return "filter";
  }
}

Color getTagColor(kfilterType type) {
  switch (type) {
    case kfilterType.filter:
      return const Color(0xFF253764);
    case kfilterType.category:
      return const Color(0xFF28aae1);
    case kfilterType.region:
    case kfilterType.municipality:
      return const Color(0xFF1c4257);
    default:
      return const Color(0xFF253764);
  }
}

bool isMobile() {
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
