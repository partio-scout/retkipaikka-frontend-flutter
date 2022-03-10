


import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/locales/app_localizations.dart';

extension Translation on String{
  String t(BuildContext context){
     return AppLocalizations.of(context).translate(this);
  }
}
