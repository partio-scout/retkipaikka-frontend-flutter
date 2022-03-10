import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/routes.dart';
import 'package:routemaster/routemaster.dart';

class LoginForm extends HookWidget {
  LoginForm({Key? key}) : super(key: key);
  final UserApi userApi = ApiService().userApi;
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Text("Kirjautuminen".t(context), style: const TextStyle(fontSize: 20)),
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
                  decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Sähköposti".t(context)+"*",
                      hintText: "a@gmail.com",
                      contentPadding:const  EdgeInsets.symmetric(horizontal: 10),
                      border:const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Sähköposti on vaadittu kenttä!".t(context)),
                      FormBuilderValidators.email(context,
                          errorText: "Sähköpostin pitää olla oikean muotoinen!".t(context))
                    ],
                  ),
                ),
                 FormInfoText(text: "Kirjoita sähköpostiosoitteesi".t(context)),
                const SizedBox(
                  height: 25,
                ),
                FormBuilderTextField(
                  name: "password",
                  obscureText: true,
                  decoration:  InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Salasana".t(context) +"*",
                      hintText: "Salasana".t(context),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Salasana on vaadittu kenttä!".t(context))
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
          child:  Text(
            "Kirjaudu".t(context),
            style: const TextStyle(color: Colors.white),
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
