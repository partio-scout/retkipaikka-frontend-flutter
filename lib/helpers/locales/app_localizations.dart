

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppLocalizations {
  static Map<String, String> _localizedValues = {};
  Map<String, String> missingKeys = {};
  AppLocalizations(this.locale);

  


  Future<bool> load() async{
    // Load the language JSON file

    String jsonString =
    await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    _localizedValues = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }
  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String translate(String key) {
    String? translation = _localizedValues[key];
    if (translation == null) {
      if (missingKeys[key] == null) {
        missingKeys[key] = key;
        if (kDebugMode) {
          print("Missing translation for key: " + key);
        }
      }
      return key;
    } else {
      return translation;
    }
  }
}
