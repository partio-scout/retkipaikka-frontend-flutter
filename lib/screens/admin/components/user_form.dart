import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/models/role_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/form/location_form.dart';

class UserForm extends HookWidget {
  const UserForm(
      {Key? key,
      required this.onSubmit,
      required this.onDelete,
      required this.user,
      required this.allRoles})
      : super(key: key);
  final Function(Map<String, dynamic>) onSubmit;
  final Function(String) onDelete;
  final List<Role> allRoles;

  final AdminUser user;
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        FormBuilder(
            initialValue: {
              "new_user": !user.newUser,
              "roles": user.roles.map((e) => e["id"]).toList(),
            },
            key: formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.username, style: const TextStyle(fontSize: 20)),
                FormBuilderCheckbox(
                  valueTransformer: (value) {
                    if (value != null) {
                      return !value;
                    }
                    return value;
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                  contentPadding: EdgeInsets.zero,
                  name: "new_user",
                  controlAffinity: ListTileControlAffinity.leading,
                  title:  Padding(
                    padding: EdgeInsets.zero,
                    child: Text(
                      "Kirjautuminen sallittu".t(context),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const FormInfoText(text: "Valitse käyttäjän kirjautumisoikeus"),
                const SizedBox(
                  height: 25,
                ),
                Text("Roolit".t(context), style: TextStyle(fontSize: 20)),
                FormBuilderCheckboxGroup(
                    name: "roles",
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    activeColor: Theme.of(context).colorScheme.primary,
                    options: allRoles.map((role) {
                      return CustomCheckbox(
                          key: ValueKey(role.id),
                          text: role.name,
                          value: role.id);
                    }).toList()),
                const FormInfoText(text: "Valitse roolit käyttäjälle"),
                const SizedBox(height: 25),
              ],
            )),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                formKey.value.currentState?.save();
                if (formKey.value.currentState != null &&
                    formKey.value.currentState!.validate()) {
                  Map<String, dynamic>? formData =
                      formKey.value.currentState?.value;
                  if (formData != null) {
                    Map<String, dynamic> data = Map.from(formData);
                    data["user"] = {
                      "admin_id": user.id,
                      "new_user": data["new_user"]
                    };
                    data.remove("new_user");
                    //Navigator.of(context).pop();
                    onSubmit(data);
                  }
                } else {
                  AlertHelper.displayErrorAlert(
                      "Lomake ei ole täytetty oikein!", context);
                }
              },
              child:  Text(
                "Tallenna".t(context),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            MaterialButton(
              color: Colors.red,
              onPressed: () {
                AlertHelper.displayConfirmAlert(
                    "Haluatko poistaa käyttäjän?", context, onConfirm: () {
                  Navigator.of(context).pop();
                  onDelete(user.id);
                }, onCancel: () {
                  Navigator.of(context).pop();
                });
              },
              child:
                   Text("Poista".t(context), style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ],
    );
  }
}
