import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retkipaikka_flutter/contants.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_autocomplete.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_dropdown_button.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class LocationForm extends HookWidget {
  LocationForm({Key? key}) : super(key: key);

  Widget formInfoText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget dynamicLayoutWrapper(BuildContext context, Widget child) {
    bool isDesktop = Responsive.isDesktop(context);

    return isDesktop ? Expanded(child: child) : SizedBox(child: child);
  }

  @override
  Widget build(BuildContext context) {
    FilteringState filteringState = context.watch<FilteringState>();
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());
    return Column(
      children: <Widget>[
        FormBuilder(
          //autovalidateMode: AutovalidateMode,
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilderTextField(
                name: 'location_name',
                decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Retkipaikka*',
                    hintText: "Esimerkkipaikka",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder()),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(context,
                        errorText: "Name is required")
                  ],
                ),
              ),
              formInfoText("Kirjoita retkipaikan nimi"),
              const SizedBox(
                height: 25,
              ),
              FormBuilderField(
                name: 'location_category',
                validator: FormBuilderValidators.compose(
                  [
                    (val) {
                      AbstractFilter? filter = val as AbstractFilter?;
                      if (filter == null || filter.id == -1) {
                        return "Category is required";
                      }
                      return null;
                    }
                  ],
                ),
                builder: (FormFieldState<dynamic> field) {
                  List<AbstractFilter> categories =
                      filteringState.allCategoryFilters;
                  return CustomDropdownButton(
                      height: 50,
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      floatingLabelStyle: null,
                      title: "Tyyppi*",
                      disabled: categories.isEmpty,
                      onDropdownChange: (AbstractFilter value) {
                        field.didChange(value);
                      },
                      errorText: field.errorText,
                      initialValue: Filter(
                          id: -1,
                          type: kfilterType.noCategory,
                          name: "Ei tyyppiä"),
                      dropdownData: categories);
                },
              ),
              formInfoText("Valitse retkipaikan tyyppi"),
              const SizedBox(
                height: 25,
              ),
              Flex(
                direction: Responsive.isDesktop(context)
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  DynamicLayoutWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderField(
                          name: 'location_area',
                          validator: FormBuilderValidators.compose(
                            [
                              (val) {
                                // AbstractFilter? filter = val as AbstractFilter?;
                                if (val == null ||
                                    filteringState.findAreaFilterByName(val) ==
                                        null) {
                                  return "Location is required";
                                }
                                return null;
                              }
                            ],
                          ),
                          builder: (FormFieldState<dynamic> field) {
                            //field.valu
                            print(field.value);
                            return CustomAutocomplete(
                              data: [
                                ...filteringState.allMunicipalities,
                                ...filteringState.allRegions
                              ],
                              value: field.value,
                              disabled: false,
                              height: 50,
                              title: "Sijainti*",
                              errorText: field.errorText,
                              clearAfterSelect: false,
                              onValueSelect: (AbstractFilter value) {
                                field.didChange(value.name);

                                //filteringState.handleFilterAdd(value);
                              },
                            );
                          },
                        ),
                        formInfoText("Valitse sijainti"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  DynamicLayoutWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'location_coordinates',
                          readOnly: true,
                          onTap: () {
                            print("TAPPED");
                          },
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Koordinaatit*',
                              hintText: "Koordinaatit",
                              errorStyle: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder()),
/*                           validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(context,
                                  errorText: "Coordinates are required")
                            ],
                          ), */
                        ),
                        formInfoText("Valitse koordinaatit kartalta"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              FormBuilderTextField(
                maxLines: 5,
                name: 'location_description',
                decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Kuvaus paikasta',
                    hintText: "Kuvaus",
                    border: OutlineInputBorder()),
              ),
              formInfoText("Kirjoita kuvaus retkipaikasta"),
              const SizedBox(height: 25),
              FormBuilderTextField(
                maxLines: 5,
                name: 'location_pricing',
                decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Vuokrahintatiedot',
                    hintText: "Tiedot",
                    border: OutlineInputBorder()),
              ),
              formInfoText("Kirjoita hintatietoja, jos niitä on"),
              const SizedBox(height: 25),
              FormBuilderCheckboxGroup(
                  name: "location_features",
                  validator: FormBuilderValidators.compose(
                    [
                      (val) {
                        if (val == null || val.isEmpty) {
                          return "At least one feature must be selected";
                        }
                        return null;
                      }
                    ],
                  ),
                  options: filteringState.allCommonFilters.map((filter) {
                    return FormBuilderFieldOption(
                        key: ValueKey(filter.id), value: filter.name);
                  }).toList()),
              formInfoText("Valitse retkipaikkaa kuvaavat asiat"),
              const SizedBox(height: 25),
              Flex(
                direction: Responsive.isDesktop(context)
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  DynamicLayoutWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'location_owner',
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Omistaja/Yhteystieto*',
                              hintText: "Esimerkkiomistaja",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(context,
                                  errorText: "Owner is required")
                            ],
                          ),
                        ),
                        formInfoText(
                            "Kirjoita kohteen omistaja (lippukunta, kaupunki, srk tms)"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  DynamicLayoutWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'location_website',
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Verkkosivu',
                              hintText: "www.retkipaikka.fi",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.url(context,
                                  errorText: "Url must be valid!")
                            ],
                          ),
                        ),
                        formInfoText("Kirjoita kohteen nettisivu"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  DynamicLayoutWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'location_email',
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Sähköposti',
                              hintText: "example@ex.com",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.email(context,
                                  errorText: "Email must be valid!")
                            ],
                          ),
                        ),
                        formInfoText("Kirjoita sähköposti"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  DynamicLayoutWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'location_phone',
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Puhelinnumero',
                              hintText: "0441234568",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder()),
                        ),
                        formInfoText("Kirjoita puhelinnumero"),
                      ],
                    ),
                  ),
                ],
              ),
              FormBuilderImagePicker(
                name: 'location_images',
                cameraLabel: Text("Kamera"),
                galleryLabel: Text("Laitteen muisti"),

                displayCustomType: (obj) =>
                    obj is ApiImage ? obj.imageUrl : obj,
                decoration: const InputDecoration(labelText: 'Valitse kuvat'),
                maxImages: 5,
                initialValue: [
                  // 'https://images.pexels.com/photos/7078045/pexels-photo-7078045.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  // const Text('this is an image\nas a widget !'),
                  // ApiImage(
                  //   id: 'whatever',
                  //   imageUrl:
                  //       'https://images.pexels.com/photos/8311418/pexels-photo-8311418.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                  // ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  formKey.value.currentState?.save();
                  if (formKey.value.currentState != null &&
                      formKey.value.currentState!.validate()) {
                    print(formKey.value.currentState?.value);
                  } else {
                    print("validation failed");
                  }
                },
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  formKey.value.currentState?.reset();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class DynamicLayoutWrapper extends StatelessWidget {
  const DynamicLayoutWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    return isDesktop ? Expanded(child: child) : SizedBox(child: child);
  }
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}
