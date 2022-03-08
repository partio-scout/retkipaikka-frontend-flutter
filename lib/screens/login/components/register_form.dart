import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterForm extends HookWidget {
  RegisterForm({Key? key}) : super(key: key);
  final UserApi userApi = UserApi();
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
                  textCapitalization: TextCapitalization.sentences,
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
                const FormInfoText(text: "Kirjoita sähköpostiosoitteesi"),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  textCapitalization: TextCapitalization.sentences,
                  name: "username",
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                FormBuilderTextField(
                  textCapitalization: TextCapitalization.sentences,
                  name: "description",
                  maxLines: 5,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Kuvaus*',
                      hintText: "Kuvaus",
                      //contentPadding: EdgeInsets.symmetric(horizontal: 10,ve),
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context,
                          errorText: "Description is required")
                    ],
                  ),
                ),
                const FormInfoText(text: "Kirjoita kuvaus itsestäsi"),
                const SizedBox(height: 20),
              ],
            )),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child: const Text(
            "Rekisteröidy",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            formKey.value.currentState?.save();
            if (formKey.value.currentState != null &&
                formKey.value.currentState!.validate()) {
              Map<String, dynamic>? formData =
                  formKey.value.currentState?.value;
              if (formData != null) {
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
