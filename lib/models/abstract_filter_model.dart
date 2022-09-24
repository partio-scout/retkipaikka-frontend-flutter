
import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/constants.dart';


abstract class AbstractFilter   {
  late int id;
  late String name;
  late kfilterType type;
  String? nameEn;
  String? nameSv;
  String? nameSmn;

  get parentId => null;

  String getTranslatedName(BuildContext context);
}
