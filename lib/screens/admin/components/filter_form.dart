import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/components/dynamic_layout_wrapper.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';

class FilterForm extends HookWidget {
  const FilterForm(
      {Key? key,
      required this.onSubmit,
      this.onDelete,
      this.initialFilter,
      this.resetAfterSubmit = true,
      required this.type,
      required this.title})
      : super(key: key);
  final Function(Map<String, dynamic>) onSubmit;
  final Function(int)? onDelete;
  final String title;
  final bool resetAfterSubmit;
  final FilterType type;
  final AbstractFilter? initialFilter;
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());
    String fieldName = type == FilterType.filter
        ? "Suodatin".t(context)
        : "Kategoria".t(context);
    String confirmText = type == FilterType.filter
        ? "Kirjoita lisättävän suodattimen nimi"
        : "Kirjoita lisättävän kategorian nimi";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20)),
        const SizedBox(
          height: 30,
        ),
        FormBuilder(
            initialValue: initialFilter != null
                ? {
                    "object_name": initialFilter!.name,
                    "object_name_sv": initialFilter!.nameSv,
                    "object_name_sa": initialFilter!.nameSmn,
                    "object_name_en": initialFilter!.nameEn,
                  }
                : {},
            key: formKey.value,
            child: Flex(
              direction: Responsive.isDesktop(context)
                  ? Axis.horizontal
                  : Axis.vertical,
              children: [
                DynamicLayoutWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderTextField(
                        textCapitalization: TextCapitalization.sentences,
                        name: "object_name",
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: fieldName + "*",
                            hintText: "Suomeksi".t(context),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: const OutlineInputBorder()),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                                errorText:
                                    "Suomenkielinen nimi on vaadittu kenttä!"
                                        .t(context))
                          ],
                        ),
                      ),
                      FormInfoText(text: confirmText),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                  width: 25,
                ),
                DynamicLayoutWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderTextField(
                        textCapitalization: TextCapitalization.sentences,
                        name: "object_name_sv",
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: fieldName,
                            hintText: "Ruotsiksi".t(context),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: const OutlineInputBorder()),
                      ),
                      FormInfoText(text: confirmText),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                  width: 25,
                ),
                DynamicLayoutWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderTextField(
                        textCapitalization: TextCapitalization.sentences,
                        name: "object_name_sa",
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: fieldName,
                            hintText: "Saameksi".t(context),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: const OutlineInputBorder()),
                      ),
                      FormInfoText(text: confirmText),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                  width: 25,
                ),
                DynamicLayoutWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderTextField(
                        textCapitalization: TextCapitalization.sentences,
                        name: "object_name_en",
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: fieldName,
                            hintText: "Englanniksi".t(context),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: const OutlineInputBorder()),
                      ),
                      FormInfoText(text: confirmText),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                  width: 25,
                ),
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
                  FocusScope.of(context).requestFocus(FocusNode());
                  Map<String, dynamic>? formData =
                      formKey.value.currentState?.value;
                  if (formData != null) {
                    if (resetAfterSubmit) {
                      formKey.value.currentState?.reset();
                    }

                    onSubmit(formData);
                  }
                } else {
                  AlertHelper.displayErrorAlert(
                      "Lomake ei ole täytetty oikein!", context);
                }
              },
              child: Text(
                "Tallenna".t(context),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            if (initialFilter != null)
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  String text = type == FilterType.category
                      ? "Haluatko poistaa kategorian?"
                      : "Haluatko poistaa suodattimen?";
                  AlertHelper.displayConfirmAlert(text, context, onConfirm: () {
                    if (initialFilter?.id != null && onDelete != null) {
                      Navigator.of(context).pop();
                      onDelete!(initialFilter!.id);
                    }
                  }, onCancel: () {
                    Navigator.of(context).pop();
                  });
                },
                child: Text("Poista".t(context),
                    style: const TextStyle(color: Colors.white)),
              )
          ],
        ),
      ],
    );
  }
}
