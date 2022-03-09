import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/components/dynamic_layout_wrapper.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';

class FilterForm extends HookWidget {
  const FilterForm(
      {Key? key,
      required this.onSubmit,
      this.onDelete,
      this.initialFilter,
      this.resetAfterSubmit = true,
      required this.title})
      : super(key: key);
  final Function(Map<String, dynamic>) onSubmit;
  final Function(int)? onDelete;
  final String title;
  final bool resetAfterSubmit;

  final AbstractFilter? initialFilter;
  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

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
                    "object_name_sa": initialFilter!.nameSa,
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
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Suodatin*',
                            hintText: "Suomeksi",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder()),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context,
                                errorText: "Finnish name is required")
                          ],
                        ),
                      ),
                      const FormInfoText(
                          text: "Kirjoita lisättävän suodattimen nimi"),
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
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Suodatin',
                            hintText: "Ruotsiksi",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder()),
                      ),
                      const FormInfoText(
                          text: "Kirjoita lisättävän suodattimen nimi"),
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
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Suodatin',
                            hintText: "Saameksi",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder()),
                      ),
                      const FormInfoText(
                          text: "Kirjoita lisättävän suodattimen nimi"),
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
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Suodatin',
                            hintText: "Englanniksi",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder()),
                      ),
                      const FormInfoText(
                          text: "Kirjoita lisättävän suodattimen nimi"),
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
              child: const Text(
                "Tallenna",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            if (initialFilter != null)
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  AlertHelper.displayConfirmAlert(
                      "Haluatko poistaa suodattimen?", context, onConfirm: () {
                    if (initialFilter?.id != null && onDelete != null) {
                      Navigator.of(context).pop();
                      onDelete!(initialFilter!.id);
                    }
                  }, onCancel: () {
                    Navigator.of(context).pop();
                  });
                },
                child:
                    const Text("Poista", style: TextStyle(color: Colors.white)),
              )
          ],
        ),
      ],
    );
  }
}
