import 'package:retkipaikka_flutter/contants.dart';

abstract class AbstractFilter {
  late int id;
  late String name;
  late kfilterType type;
  String? nameEn;
  String? nameSv;
  String? nameSa;

  get parentId => null;
}
