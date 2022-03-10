import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/helpers/locales/app_localizations.dart';



class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      kSupportedLocales.keys.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async{
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    
    AppLocalizations locales = AppLocalizations(locale);
    await locales.load();
    if(kDebugMode){
      print(locale.languageCode + " loaded");
    }
    
    return SynchronousFuture<AppLocalizations>(locales);
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
