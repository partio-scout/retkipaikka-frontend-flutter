import 'package:retkipaikka_flutter/models/date_parser.dart';

class AppNotification extends DateParser {
  int? id;
  String text;
  String? textEn;
  String? textSv;
  String? textSa;

  String title;
  String? titleEn;
  String? titleSv;
  String? titleSa;

  String? linkText;
  String? linkTextEn;
  String? linkTextSv;
  String? linkTextSa;

  String? linkUrl;

  bool displayInFrontPage;
  bool displayInList;

  AppNotification(
      {this.id,
      required this.text,
      required this.title,
      required this.displayInFrontPage,
      required this.displayInList,
      this.textEn,
      this.textSa,
      this.textSv,
      this.titleEn,
      this.titleSa,
      this.titleSv,
      this.linkText,
      this.linkTextEn,
      this.linkTextSa,
      this.linkTextSv,
      this.linkUrl,
      updatedAt})
      : super(updatedAt: updatedAt);

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
        id: json["notification_id"],
        text: json["text"],
        textEn: json["text_en"],
        textSa: json["text_sa"],
        textSv: json["text_sv"],
        title: json["title"],
        titleEn: json["title_en"],
        titleSa: json["title_sa"],
        titleSv: json["title_sv"],
        linkText: json["link_text"],
        linkTextEn: json["link_text_en"],
        linkTextSa: json["link_text_sa"],
        linkTextSv: json["link_text_sv"],
        linkUrl: json["link_url"],
        displayInFrontPage: json["display_frontpage"] ?? false,
        displayInList: json["enabled"] ?? false,
        updatedAt: json["updatedAt"]);
  }
}
