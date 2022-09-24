import 'package:flutter/src/widgets/framework.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/models/date_parser.dart';

class AppNotification extends DateParser {
  int? id;
  String text;
  String? textEn;
  String? textSv;
  String? textSmn;

  String title;
  String? titleEn;
  String? titleSv;
  String? titleSmn;

  String? linkText;
  String? linkTextEn;
  String? linkTextSv;
  String? linkTextSmn;

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
      this.textSmn,
      this.textSv,
      this.titleEn,
      this.titleSmn,
      this.titleSv,
      this.linkText,
      this.linkTextEn,
      this.linkTextSmn,
      this.linkTextSv,
      this.linkUrl,
      updatedAt})
      : super(updatedAt: updatedAt);

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
        id: json["notification_id"],
        text: json["text"],
        textEn: json["text_en"],
        textSmn: json["text_sa"],
        textSv: json["text_sv"],
        title: json["title"],
        titleEn: json["title_en"],
        titleSmn: json["title_sa"],
        titleSv: json["title_sv"],
        linkText: json["link_text"],
        linkTextEn: json["link_text_en"],
        linkTextSmn: json["link_text_sa"],
        linkTextSv: json["link_text_sv"],
        linkUrl: json["link_url"],
        displayInFrontPage: json["display_frontpage"] ?? false,
        displayInList: json["enabled"] ?? false,
        updatedAt: json["updatedAt"]);
  }

  String getTranslatedText(BuildContext context) {
    String locale = context.read<AppState>().appLocale.languageCode;

    switch (locale) {
      case "fi":
        return text;
      case "en":
        return textEn ?? text;
      case "smn":
        return textSmn ?? textEn ?? text;
      case "sv":
        return textSv ?? textEn ?? text;
      default:
        return text;
    }
  }

  String getTranslatedTitle(BuildContext context) {
    String locale = context.read<AppState>().appLocale.languageCode;

    switch (locale) {
      case "fi":
        return title;
      case "en":
        return titleEn ?? title;
      case "smn":
        return titleSmn ?? titleEn ?? title;
      case "sv":
        return titleSv ?? titleEn ?? title;
      default:
        return title;
    }
  }

  String getTranslatedLinkText(BuildContext context) {
    String locale = context.read<AppState>().appLocale.languageCode;

    switch (locale) {
      case "fi":
        return linkText ?? "";
      case "en":
        return linkTextEn ?? linkText ?? "";
      case "smn":
        return linkTextSmn ?? linkTextEn ?? linkText ?? "";
      case "sv":
        return linkTextSv ?? linkTextEn ?? linkText ?? "";
      default:
        return linkText ?? "";
    }
  }
}
