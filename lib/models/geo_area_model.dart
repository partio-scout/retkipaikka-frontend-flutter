import 'package:flutter/src/widgets/framework.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';

class GeoArea implements AbstractFilter {
  @override
  int id;
  @override
  String name;
  @override
  kfilterType type;
  @override
  int? parentId;
  @override
  String? nameEn;
  @override
  String? nameSmn;
  @override
  String? nameSv;

  GeoArea(
      {required this.id,
      required this.type,
      required this.name,
      this.parentId});

  factory GeoArea.fromJson(Map<String, dynamic> json) {
    return GeoArea(
        id: json["municipality_id"] ?? json["region_id"],
        type: typeToFilterType(
            json["municipality_id"] != null ? "municipality" : "region"),
        name: json["object_name"],
        parentId: json["municipality_id"] != null ? json["region_id"] : null);
  }

  @override
  bool operator ==(other) =>
      other is GeoArea && (other.id == id && other.name == name);

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;

  @override
  String getTranslatedName(BuildContext context) {
    return name;
  }
}
