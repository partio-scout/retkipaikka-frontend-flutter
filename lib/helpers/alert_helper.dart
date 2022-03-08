import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

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
            title: text,
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
    CoolAlert.show(
            context: context,
            width: 400,
            type: CoolAlertType.error,
            //text: text,
            title: text.toString(),
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
            confirmBtnText: "Ok",
            onConfirmBtnTap: onConfirm,
            onCancelBtnTap: onCancel,
            showCancelBtn: true,
            cancelBtnText: "Cancel",
            title: text,
            confirmBtnColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor
            //autoCloseDuration: Duration(seconds: 2),
            )
        .then((value) => isDialogOpen = false);
  }
}
