import 'package:flutter/src/widgets/framework.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:provider/provider.dart';

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
  String? nameSmn;
  @override
  String? nameSv;

  Filter(
      {required this.id,
      required this.type,
      required this.name,
      this.nameEn,
      this.nameSv,
      this.nameSmn});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
        id: json["filter_id"] ?? json["category_id"],
        type: typeToFilterType(json["object_type"]),
        name: json["object_name"],
        nameEn: json["object_name_en"],
        nameSv: json["object_name_sv"],
        nameSmn: json["object_name_sa"]);
  }

  @override
  get parentId => null;

  @override
  bool operator ==(other) =>
      other is Filter && (other.id == id && other.type == type);

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;

  @override
  String getTranslatedName(BuildContext context) {
    String locale = context.read<AppState>().appLocale.languageCode;

    switch (locale) {
      case "fi":
        return name;
      case "en":
        return nameEn ?? name;
      case "smn":
        return nameSmn ?? nameEn ?? name;
      case "sv":
        return nameSv ?? nameEn ?? name;
      default:
        return name;
    }
  }
}
