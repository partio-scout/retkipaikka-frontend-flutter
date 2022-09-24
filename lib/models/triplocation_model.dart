import 'package:latlong2/latlong.dart';
import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';
import 'package:retkipaikka_flutter/models/date_parser.dart';

class TripLocation extends DateParser {
  String id;
  int category;
  String region;
  String name;
  Map<String, dynamic> geo;
  bool accepted;
  String? owner;
  String? municipality;
  String? description;
  String? pricing;
  String? website;
  String? phone;
  String? mail;
  String? editorName;

  List<int> filters;
  List<String> images;
  bool isFavourite;

  TripLocation({
    required this.id,
    required this.category,
    required this.region,
    required this.name,
    required this.geo,
    required this.accepted,
    required this.owner,
    this.municipality,
    this.description,
    this.pricing,
    this.website,
    this.phone,
    this.mail,
    this.editorName,
    this.filters = const [],
    this.images = const [],
    this.isFavourite = false,
    createdAt,
    updatedAt,
  }) : super(createdAt: createdAt, updatedAt: updatedAt);

  factory TripLocation.fromJson(Map<String, dynamic> json) {
    return TripLocation(
        id: json["location_id"],
        category: json["location_category"],
        region: json["location_region"],
        name: json["location_name"],
        geo: json["location_geo"],
        accepted: json["location_accepted"] ?? true,
        owner: json["location_owner"],
        municipality: json["location_municipality"],
        description: json["location_description"],
        pricing: json["location_pricing"],
        website: json["location_website"],
        phone: json["location_phone"],
        mail: json["location_mail"],
        editorName: json["location_editor"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        filters: json["filters"] != null ? json["filters"].cast<int>() : [],
        images: json["images"] != null ? json["images"].cast<String>() : []);
  }

  LatLng getCoordinates() {
    return LatLng(geo["lat"], geo["lng"]);
  }

  String getCoordinatesStringified() {
    return "${geo["lat"]}, ${geo["lng"]}";
  }

  Future<bool> toggleFavourite() async {
    bool currentFav = isFavourite;
    isFavourite = !isFavourite;

    if (currentFav) {
      return SharedPreferencesHelper.removeUserFavourite(id);
    } else {
      return SharedPreferencesHelper.addUserFavourite(id);
    }
  }
}
