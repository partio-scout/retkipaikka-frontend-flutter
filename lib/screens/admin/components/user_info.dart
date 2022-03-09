import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, required this.user}) : super(key: key);
  final AdminUser? user;
  List<Widget> textInfoCombo(String title, String? info) {
    return [
      Text(title, style: const TextStyle(fontSize: 20)),
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
        ...textInfoCombo("Luotu:", user?.createdAt),
        ...textInfoCombo("Rooli:",
            user?.roles.map((role) => role["name"]).toList().join(",")),
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
  final UserApi userApi = UserApi();
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Käyttäjänimi ja sähköposti",
            style: TextStyle(fontSize: 20)),
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
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Sähköposti*',
                      hintText: "a@gmail.com",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Email is required"),
                      FormBuilderValidators.email(context,
                          errorText: "Value is not valid email!")
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita sähköpostiosoite"),
                const SizedBox(
                  height: 25,
                ),
                FormBuilderTextField(
                  name: "username",
                  obscureText: false,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Käyttäjänimi*',
                      hintText: "Käyttäjänimi",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Username is required")
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
          child: const Text(
            "Tallenna",
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
                      "Tietojen muokkaus onnistui", context);
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
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Nykyinen salasana*',
                      hintText: "Salasana",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder()),
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
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Uusi salasana*',
                      hintText: "Salasana",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder()),
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
          child: const Text(
            "Tallenna",
            style: TextStyle(color: Colors.white),
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
                      "Salasanan vaihto onnistui", context);
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
