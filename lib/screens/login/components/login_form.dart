import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/routes.dart';
import 'package:routemaster/routemaster.dart';

class LoginForm extends HookWidget {
  LoginForm({Key? key}) : super(key: key);
  final UserApi userApi = UserApi();
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Kirjautuminen", style: TextStyle(fontSize: 20)),
        const SizedBox(
          height: 30,
        ),
        FormBuilder(
            key: formKey.value,
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
                  name: "password",
                  obscureText: true,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Salasana*',
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
                const FormInfoText(text: "Kirjoita salasanasi"),
              ],
            )),
        const SizedBox(
          height: 25,
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child: const Text(
            "Kirjaudu",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            formKey.value.currentState?.save();
            if (formKey.value.currentState != null &&
                formKey.value.currentState!.validate()) {
              Map<String, dynamic>? formData =
                  formKey.value.currentState?.value;
              if (formData != null) {
                FocusScope.of(context).requestFocus(FocusNode());
                userApi.login(formData).then((res) {
                  return context.read<AppState>().handleAfterLogin(res);
                }).then((value) {
                  AlertHelper.displaySuccessAlert(
                      "Kirjautuminen onnistui!", context, cb: () {
                    Routemaster.of(context).push(AdminRoutes.adminNew);
                  });
                  formKey.value.currentState?.reset();
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
