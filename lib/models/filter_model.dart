import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';

class Filter implements AbstractFilter {
  @override
  int id;
  @override
  kfilterType type;
  @override
  String name;
  @override
  String? nameEn;
  @override
  String? nameSa;
  @override
  String? nameSv;

  Filter(
      {required this.id,
      required this.type,
      required this.name,
      this.nameEn,
      this.nameSv,
      this.nameSa});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
        id: json["filter_id"] ?? json["category_id"],
        type: typeToFilterType(json["object_type"]),
        name: json["object_name"],
        nameEn: json["object_name_en"],
        nameSv: json["object_name_sv"],
        nameSa: json["object_name_sa"]);
  }

  @override
  // TODO: implement parentId
  get parentId => null;




}
