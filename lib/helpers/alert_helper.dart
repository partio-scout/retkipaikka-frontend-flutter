import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';

class AlertHelper {
  static bool isDialogOpen = false;
  static void displaySuccessAlert(String text, BuildContext context,
      {Function()? cb}) {
    if (isDialogOpen) return;
    isDialogOpen = true;
  
    
    
    CoolAlert.show(       
            context: context,
            type: CoolAlertType.success,
            width: 400,
            title: text.t(context),
            confirmBtnColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor
            //autoCloseDuration: Duration(seconds: 2),
            )
        .then((value) {
      isDialogOpen = false;
      if (cb != null) {
        cb();
      }
    });
  }

  static void displayErrorAlert(dynamic text, BuildContext context) {
    if (isDialogOpen) return;
    isDialogOpen = true;
    String parsed =text.toString();
    CoolAlert.show(
            context: context,
            width: 400,
            type: CoolAlertType.error,
            //text: text,
            title: parsed.t(context),
            confirmBtnColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor
            //autoCloseDuration: Duration(seconds: 2),
            )
        .then((value) => isDialogOpen = false);
  }

  static void displayInfoAlert(String text, BuildContext context) {
    if (isDialogOpen) return;
    isDialogOpen = true;
    CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            width: 400,
            title: text,
            confirmBtnColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor

            //autoCloseDuration: Duration(seconds: 2),
            )
        .then((value) => isDialogOpen = false);
  }

  static void displayConfirmAlert(String text, BuildContext context,
      {required void Function() onConfirm, required void Function() onCancel}) {
    if (isDialogOpen) return;
   
    CoolAlert.show(
            context: context,
            type: CoolAlertType.confirm,
            width: 400,      
            onConfirmBtnTap: onConfirm,
            onCancelBtnTap: onCancel,
            showCancelBtn: true,
            cancelBtnText: "Peruuta".t(context),
             title: text.t(context),
            confirmBtnColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor
            //autoCloseDuration: Duration(seconds: 2),
            )
        .then((value) => isDialogOpen = false);
  }
}
