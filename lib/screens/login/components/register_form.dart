import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';

class RegisterForm extends HookWidget {
  RegisterForm({Key? key}) : super(key: key);
  final UserApi userApi = ApiService().userApi;
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Rekisteröityminen", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 30),
        FormBuilder(
            key: formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderTextField(
                  name: "email",
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "${"Sähköposti".t(context)}*",
                      hintText: "a@gmail.com",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                          errorText:
                              "Sähköposti on vaadittu kenttä!".t(context)),
                      FormBuilderValidators.email(
                          errorText: "Sähköpostin pitää olla oikean muotoinen!"
                              .t(context))
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita sähköpostiosoitteesi"),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  textCapitalization: TextCapitalization.sentences,
                  name: "username",
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "${"Käyttäjänimi".t(context)}*",
                      hintText: "Käyttäjänimi".t(context),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                          errorText:
                              "Käyttäjänimi on vaadittu kenttä!".t(context))
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita käyttäjänimesi"),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: "password",
                  obscureText: true,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "${"Salasana".t(context)}*",
                      hintText: "Salasana".t(context),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                          errorText: "Salasana on vaadittu kenttä!".t(context))
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita salasanasi"),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  textCapitalization: TextCapitalization.sentences,
                  name: "description",
                  maxLines: 5,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "${"Kuvaus".t(context)}*",
                      hintText: "Kuvaus".t(context),
                      //contentPadding: EdgeInsets.symmetric(horizontal: 10,ve),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                          errorText: "Kuvaus on vaadittu kenttä!".t(context))
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita kuvaus itsestäsi"),
                const SizedBox(height: 20),
              ],
            )),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "Rekisteröidy".t(context),
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
                userApi.register(formData).then((res) {
                  AlertHelper.displaySuccessAlert(
                      "Rekisteröityminen onnistui!", context);
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
