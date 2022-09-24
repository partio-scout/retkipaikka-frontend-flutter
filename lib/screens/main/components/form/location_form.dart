import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/triplocation_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_autocomplete.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_checkbox.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_dropdown_button.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_image_picker.dart';
import 'package:retkipaikka_flutter/helpers/components/dynamic_layout_wrapper.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:retkipaikka_flutter/helpers/form_parser.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/models/filter_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/models/triplocation_model.dart';
import 'package:retkipaikka_flutter/screens/main/components/map/location_map.dart';

class LocationForm extends HookWidget {
  LocationForm({Key? key, this.initialLocation, this.afterFormSave})
      : super(key: key);
  final TripLocationApi tripLocationApi = ApiService().triplocationApi;
  final TripLocation? initialLocation;
  final Function()? afterFormSave;
  @override
  Widget build(BuildContext context) {
    FilteringState filteringState = context.watch<FilteringState>();
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    CustomMarker? marker = context.watch<TripLocationState>().selectedMarker;
    useEffect(() {
      if (formKey.value.currentState != null && marker != null) {
        formKey.value.currentState?.fields['location_geo']?.didChange(
            marker.point.latitude.toString() +
                ", " +
                marker.point.longitude.toString());
      }
      return null;
    }, [marker]);
    //Locale currentLocale = context.select((AppState a) => a.appLocale,);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FormBuilder(
          initialValue: initialLocation != null
              ? {
                  "location_name": initialLocation!.name,
                  "location_category": initialLocation!.category,
                  "location_area":
                      initialLocation!.municipality ?? initialLocation!.region,
                  "location_geo": initialLocation!.getCoordinatesStringified(),
                  "location_description": initialLocation!.description,
                  "location_pricing": initialLocation!.pricing,
                  "filters": initialLocation!.filters,
                  "location_owner": initialLocation!.owner,
                  "location_website": initialLocation!.website,
                  "location_mail": initialLocation!.mail,
                  "location_phone": initialLocation!.phone,
                  "location_images": FormParser.imageStringsToXFile(
                      initialLocation!.images, initialLocation!.id),
                  "location_accepted": initialLocation!.accepted
                }
              : {},
          //autovalidateMode: AutovalidateMode,
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                name: 'location_name',
                textInputAction: TextInputAction.none,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Retkipaikka'.t(context) + "*",
                    hintText: "Esimerkkipaikka".t(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: const OutlineInputBorder()),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(context,
                        errorText: "Nimi on pakollinen kenttä!".t(context))
                  ],
                ),
              ),
              const FormInfoText(text: "Kirjoita retkipaikan nimi"),
              const SizedBox(
                height: 25,
              ),
              FormBuilderField(
                name: 'location_category',
                validator: FormBuilderValidators.compose(
                  [
                    (val) {
                      //AbstractFilter? filter = val as AbstractFilter?;
                      if (val == null || val == -1) {
                        return "Kategoria on pakollinen kenttä!".t(context);
                      }
                      return null;
                    }
                  ],
                ),
                builder: (FormFieldState<dynamic> field) {
                  List<AbstractFilter> categories =
                      filteringState.allCategoryFilters;

                  Filter initialFilter = Filter(
                      id: -1,
                      type: kfilterType.noCategory,
                      name: "Ei tyyppiä".t(context));
                  return CustomDropdownButton(
                      height: 50,
                      bgColor: Colors.white,
                      focusColor: Colors.white,
                      floatingLabelStyle: null,
                      title: "Tyyppi".t(context) + "*",
                      disabled: categories.isEmpty,
                      onDropdownChange: (AbstractFilter value) {
                        field.didChange(value.id);
                      },
                      errorText: field.errorText,
                      initialValue:
                          filteringState.getCategoryById(field.value) ??
                              initialFilter,
                      dropdownData: [
                        initialFilter,
                        ...filteringState.allCategoryFilters
                      ]);
                },
              ),
              const FormInfoText(text: "Valitse retkipaikan tyyppi"),
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
                                  return "Sijainti on pakollinen kenttä!"
                                      .t(context);
                                }
                                return null;
                              }
                            ],
                          ),
                          builder: (FormFieldState<dynamic> field) {
                            //field.valu
                            //print(field.value);
                            return CustomAutocomplete(
                              data: [
                                ...filteringState.allMunicipalities,
                                ...filteringState.allRegions
                              ],
                              value: field.value,
                              disabled: false,
                              height: 50,
                              title: "Sijainti".t(context) + "*",
                              errorText: field.errorText,
                              clearAfterSelect: false,
                              onValueSelect: (AbstractFilter value) {
                                field.didChange(value.name);

                                //filteringState.handleFilterAdd(value);
                              },
                            );
                          },
                        ),
                        const FormInfoText(text: "Valitse sijainti"),
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
                          name: 'location_geo',
                          readOnly: true,
                          onTap: () {
                            context.read<AppState>().scrollController.animateTo(
                                200,
                                duration: const Duration(milliseconds: 50),
                                curve: Curves.linear);
                          },
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Koordinaatit'.t(context) + "*",
                              hintText: "Koordinaatit".t(context),
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
                        const FormInfoText(
                            text: "Valitse koordinaatit kartalta"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                name: 'location_description',
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Kuvaus paikasta'.t(context),
                    hintText: "Kuvaus".t(context),
                    border: const OutlineInputBorder()),
              ),
              const FormInfoText(text: "Kirjoita kuvaus retkipaikasta"),
              const SizedBox(height: 25),
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                name: 'location_pricing',
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Vuokrahintatiedot'.t(context),
                    hintText: "Tiedot".t(context),
                    border: const OutlineInputBorder()),
              ),
              const FormInfoText(text: "Kirjoita hintatietoja, jos niitä on"),
              const SizedBox(height: 25),
              FormBuilderCheckboxGroup(
                  name: "filters",
                  validator: FormBuilderValidators.compose(
                    [
                      (val) {
                        if (val == null || val.isEmpty) {
                          return "Vähintään yksi ominaisuus pitää olla valittuna!"
                              .t(context);
                        }
                        return null;
                      }
                    ],
                  ),
                  activeColor: Theme.of(context).colorScheme.primary,
                  options: filteringState.allCommonFilters.map((filter) {
                    return CustomCheckbox(
                        key: ValueKey(filter.id),
                        text: filter.getTranslatedName(context),
                        value: filter.id);
                  }).toList()),
              const FormInfoText(text: "Valitse retkipaikkaa kuvaavat asiat"),
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
                          textCapitalization: TextCapitalization.sentences,
                          name: 'location_owner',
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText:
                                  'Omistaja/Yhteystieto'.t(context) + '*',
                              hintText: "Esimerkkiomistaja".t(context),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(context,
                                  errorText: "Omistaja on pakollinen kenttä"
                                      .t(context))
                            ],
                          ),
                        ),
                        const FormInfoText(
                            text:
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
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Verkkosivu'.t(context),
                              hintText: "www.retkipaikka.fi",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder()),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.url(context,
                                  errorText:
                                      "Osoitteen pitää olla validi url osoite!"
                                          .t(context))
                            ],
                          ),
                        ),
                        const FormInfoText(text: "Kirjoita kohteen nettisivu"),
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
                          name: 'location_mail',
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Sähköposti'.t(context),
                              hintText: "example@ex.com",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder()),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.email(context,
                                  errorText:
                                      "Sähköpostin pitää olla oikean muotoinen!"
                                          .t(context))
                            ],
                          ),
                        ),
                        const FormInfoText(text: "Kirjoita sähköposti"),
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
                          textCapitalization: TextCapitalization.sentences,
                          name: 'location_phone',
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Puhelinnumero'.t(context),
                              hintText: "0441234568",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder()),
                        ),
                        const FormInfoText(text: "Kirjoita puhelinnumero"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              initialLocation != null
                  ? FormBuilderCheckbox(
                      activeColor: Theme.of(context).colorScheme.primary,
                      contentPadding: EdgeInsets.zero,
                      name: "location_accepted",
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Padding(
                          padding: EdgeInsets.zero,
                          child: Text(
                              "Retkipaikka näkyvissä käyttäjälle".t(context))))
                  : const SizedBox(),
              FormBuilderField(
                name: 'location_images',
                builder: (FormFieldState<dynamic> field) {
                  return CustomImagePicker(
                      value: field.value ?? [],
                      onDataChanged: (currentData, initialData) {
                        field.didChange(currentData);
                      });
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "Lähetä".t(context),
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
                formData = Map.from(formData);
                List<XFile> images = [];
                if (formData["location_images"] != null) {
                  images = formData["location_images"];
                  formData.remove("location_images");
                }

                Map<String, dynamic>? parsedFormData =
                    FormParser.afterLocationFormSubmit(formData, context);

                if (parsedFormData != null) {
                  if (initialLocation != null) {
                    if (parsedFormData["filters"].length ==
                        initialLocation!.filters.length) {
                      parsedFormData.remove("filters");
                    }

                    parsedFormData["location_id"] = initialLocation!.id;
                    parsedFormData["location_editor"] =
                        context.read<AppState>().currentUser?.username;

                    List<XFile> newImages = images
                        .where(
                            (element) => !element.path.contains("/api/Images/"))
                        .toList();
                    List<XFile> oldImages = images
                        .where(
                            (element) => element.path.contains("/api/Images/"))
                        .toList();
                    List<String> imagesToDelete = [];
                    if (initialLocation?.images.length != oldImages.length) {
                      imagesToDelete = initialLocation!.images
                          .where((initialImg) =>
                              oldImages.indexWhere((oldImg) =>
                                  oldImg.path.contains(initialImg)) ==
                              -1)
                          .toList();
                    }

                    tripLocationApi
                        .deleteLocationImages(
                            initialLocation!.id, imagesToDelete)
                        .then((res) {
                      return tripLocationApi.handleTripLocationEdit(
                          parsedFormData, newImages);
                    }).then((value) {
                      AlertHelper.displaySuccessAlert(
                          "Retkipaikkaa muokattu onnistuneesti!", context,
                          cb: afterFormSave);
                    }).catchError((error) {
                      AlertHelper.displayErrorAlert(error, context);
                    });
                  } else {
                    tripLocationApi
                        .handleTripLocationPost(parsedFormData, images)
                        .then((value) {
                      formKey.value.currentState?.reset();

                      AlertHelper.displaySuccessAlert(
                          "Retkipaikka ilmoitettu onnistuneesti!", context,
                          cb: afterFormSave);
                    }).catchError((error) {
                      AlertHelper.displayErrorAlert(error, context);
                    });
                  }
                }
              }
            } else {
              FocusScope.of(context).requestFocus(FocusNode());
              AlertHelper.displayErrorAlert(
                  "Lomake ei ole täytetty oikein!", context);
            }
          },
        ),
      ],
    );
  }
}

