import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, required this.user}) : super(key: key);
  final AdminUser? user;
  List<Widget> textInfoCombo(String title, String? info,BuildContext context) {
    return [
      Text(title.t(context), style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 5),
      Text(info ?? "-"),
      const SizedBox(
        height: 15,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...textInfoCombo("Luotu", user?.createdAt,context),
        ...textInfoCombo("Rooli",
            user?.roles.map((role) => role["name"]).toList().join(","),context),
        InfoForm(
          user: user,
        ),
        const SizedBox(
          height: 25,
        ),
        PasswordForm(
          user: user,
        )
      ],
    );
  }
}

class InfoForm extends HookWidget {
  InfoForm({Key? key, required this.user}) : super(key: key);
  final AdminUser? user;
  final UserApi userApi = ApiService().userApi;
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
         Text("Käyttäjänimi ja sähköposti".t(context),
            style:const  TextStyle(fontSize: 20)),
        const SizedBox(
          height: 30,
        ),
        FormBuilder(
            key: formKey.value,
            initialValue: user != null
                ? {"email": user!.email, "username": user!.username}
                : {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderTextField(
                  name: "email",
                  decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Sähköposti".t(context)+"*",
                      hintText: "a@gmail.com",
                      contentPadding:const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Sähköposti on vaadittu kenttä!".t(context)),
                      FormBuilderValidators.email(context,
                          errorText: "Sähköpostin pitää olla oikean muotoinen!".t(context))
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita sähköpostiosoitteesi"),
                const SizedBox(
                  height: 25,
                ),
                FormBuilderTextField(
                  name: "username",
                  obscureText: false,
                  decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Käyttäjänimi".t(context)+"*",
                      hintText: "Käyttäjänimi".t(context),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Käyttäjänimi on vaadittu kenttä!".t(context))
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita käyttäjänimesi"),
              ],
            )),
        const SizedBox(
          height: 25,
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "Tallenna".t(context),
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            formKey.value.currentState?.save();
            if (formKey.value.currentState != null &&
                formKey.value.currentState!.validate()) {
              Map<String, dynamic>? formData =
                  formKey.value.currentState?.value;
              if (formData != null) {
                userApi.modifyOwnUserSettings(user!.id, formData).then((value) {
                  return userApi.fetchSingleUser(user!.id, user!.token);
                }).then((value) {
                  context.read<AppState>().handleAfterUserUpdate(value);
                  AlertHelper.displaySuccessAlert(
                      "Tietojen muokkaus onnistui!", context);
                }).catchError((err) {
                  AlertHelper.displayErrorAlert(err, context);
                });
              }
            } else {
              AlertHelper.displayErrorAlert(
                  "Lomake ei ole täytetty oikein!", context);
            }
          },
        ),
      ],
    );
  }
}

class PasswordForm extends HookWidget {
  PasswordForm({Key? key, required this.user}) : super(key: key);
  final UserApi userApi = UserApi();
  final AdminUser? user;
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Salasanan vaihto", style: TextStyle(fontSize: 20)),
        const SizedBox(
          height: 30,
        ),
        FormBuilder(
            key: formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderTextField(
                  name: "oldPassword",
                  obscureText: true,
                  decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Nykyinen salasana".t(context)+"*",
                      hintText: "Salasana".t(context),
                      contentPadding:const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Password is required"),
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita vanha salasana"),
                const SizedBox(
                  height: 25,
                ),
                FormBuilderTextField(
                  name: "newPassword",
                  obscureText: true,
                  decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Uusi salasana".t(context)+"*",
                      hintText: "Salasana".t(context),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Password is required")
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita uusi salasana"),
              ],
            )),
        const SizedBox(
          height: 25,
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child:  Text(
            "Tallenna".t(context),
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            formKey.value.currentState?.save();
            if (formKey.value.currentState != null &&
                formKey.value.currentState!.validate()) {
              Map<String, dynamic>? formData =
                  formKey.value.currentState?.value;
              if (formData != null) {
                userApi.changePassword(user!.id, formData).then((value) {
                  return userApi.fetchSingleUser(user!.id, user!.token);
                }).then((value) {
                  context.read<AppState>().handleAfterUserUpdate(value);
                  AlertHelper.displaySuccessAlert(
                      "Salasanan vaihto onnistui!", context);
                }).catchError((err) {
                  AlertHelper.displayErrorAlert(err, context);
                });
              }
            } else {
              AlertHelper.displayErrorAlert(
                  "Lomake ei ole täytetty oikein!", context);
            }
          },
        ),
      ],
    );
  }
}
