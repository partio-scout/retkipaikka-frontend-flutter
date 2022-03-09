import 'package:intl/intl.dart';

abstract class DateParser {
  DateParser({this.createdAt, this.updatedAt});
  String? createdAt;
  String? updatedAt;

  String? createdAtParsed() {
    if (createdAt == null) return null;
    return DateFormat("dd.MM.yyyy").format(DateTime.parse(createdAt!));
  }

  String? updatedAtParsed() {
    if (updatedAt == null) return null;
    return DateFormat("dd.MM.yyyy").format(DateTime.parse(updatedAt!));
  }
}
