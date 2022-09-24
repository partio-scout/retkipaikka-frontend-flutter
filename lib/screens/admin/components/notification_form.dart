import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/components/dynamic_layout_wrapper.dart';
import 'package:retkipaikka_flutter/helpers/components/form_info_text.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';

import 'package:retkipaikka_flutter/models/app_notification_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/screens/admin/components/notification_builder.dart';

class NotificationForm extends HookWidget {
  const NotificationForm(
      {Key? key,
      required this.notification,
      required this.onSubmit,
      this.onDelete})
      : super(key: key);
  final AppNotification? notification;
  final Function(Map<String, dynamic>) onSubmit;
  final Function(int)? onDelete;

  @override
  Widget build(BuildContext context) {
    var formKey =
        useState<GlobalKey<FormBuilderState>>(GlobalKey<FormBuilderState>());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Ilmoituksen luonti".t(context),
            style: const TextStyle(fontSize: 20)),
        const SizedBox(
          height: 30,
        ),
        FormBuilder(
            initialValue: notification != null
                ? {
                    "title": notification!.title,
                    "title_sv": notification!.titleSv,
                    "title_sa": notification!.titleSmn,
                    "title_en": notification!.titleEn,
                    "text": notification!.text,
                    "text_sv": notification!.textSv,
                    "text_sa": notification!.textSmn,
                    "text_en": notification!.textEn,
                    "link_text": notification!.linkText,
                    "link_text_sv": notification!.linkTextSv,
                    "link_text_sa": notification!.linkTextSmn,
                    "link_text_en": notification!.linkTextEn,
                    "link_url": notification!.linkUrl,
                    "enabled": notification!.displayInList,
                    "display_frontpage": notification!.displayInFrontPage
                  }
                : {"enabled": false, "display_frontpage": false},
            key: formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.title = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "title",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: "Otsikko".t(context) + "*",
                                  hintText: "Suomeksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                            const FormInfoText(
                                text: "Kirjoita ilmoituksen otsikko"),
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
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.titleSv = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "title_sv",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Otsikko'.t(context),
                                  hintText: "Ruotsiksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: const OutlineInputBorder()),
                            ),
                            const FormInfoText(
                                text: "Kirjoita ilmoituksen otsikko"),
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
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.titleSmn = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "title_sa",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: "Otsikko".t(context),
                                  hintText: "Saameksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: const OutlineInputBorder()),
                            ),
                            const FormInfoText(
                                text: "Kirjoita ilmoituksen otsikko"),
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
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.titleEn = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "title_en",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Otsikko'.t(context),
                                  hintText: "Englanniksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: const OutlineInputBorder()),
                            ),
                            const FormInfoText(
                                text: "Kirjoita ilmoituksen otsikko"),
                          ],
                        ),
                      ),
                    ]),
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
                            FormBuilderTextField(
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.text = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "text",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: "Teksti".t(context) + "*",
                                  hintText: "Suomeksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                            const FormInfoText(text: "Kirjoita teksti"),
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
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.textSv = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "text_sv",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Teksti'.t(context),
                                  hintText: "Ruotsiksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: const OutlineInputBorder()),
                            ),
                            const FormInfoText(text: "Kirjoita teksti"),
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
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.textSmn = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "text_sa",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Teksti'.t(context),
                                  hintText: "Saameksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: const OutlineInputBorder()),
                            ),
                            const FormInfoText(text: "Kirjoita teksti"),
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
                              onChanged: (val) {
                                if (val != null) {
                                  NotificationBuilderState s =
                                      context.read<NotificationBuilderState>();
                                  s.notification.textEn = val;
                                  s.notify();
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              name: "text_en",
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Teksti'.t(context),
                                  hintText: "Englanniksi".t(context),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: const OutlineInputBorder()),
                            ),
                            const FormInfoText(text: "Kirjoita teksti"),
                          ],
                        ),
                      ),
                    ]),
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
                          FormBuilderTextField(
                            onChanged: (val) {
                              if (val != null) {
                                NotificationBuilderState s =
                                    context.read<NotificationBuilderState>();
                                s.notification.linkText = val;
                                s.notify();
                              }
                            },
                            textCapitalization: TextCapitalization.sentences,
                            name: "link_text",
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Linkin teksti'.t(context),
                                hintText: "Suomeksi".t(context),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: const OutlineInputBorder()),
                          ),
                          const FormInfoText(text: "Kirjoita linkin teksti"),
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
                            onChanged: (val) {
                              if (val != null) {
                                NotificationBuilderState s =
                                    context.read<NotificationBuilderState>();
                                s.notification.linkTextSv = val;
                                s.notify();
                              }
                            },
                            textCapitalization: TextCapitalization.sentences,
                            name: "link_text_sv",
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Linkin teksti'.t(context),
                                hintText: "Ruotsiksi".t(context),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: const OutlineInputBorder()),
                          ),
                          const FormInfoText(text: "Kirjoita linkin teksti"),
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
                            onChanged: (val) {
                              if (val != null) {
                                NotificationBuilderState s =
                                    context.read<NotificationBuilderState>();
                                s.notification.linkTextSmn = val;
                                s.notify();
                              }
                            },
                            textCapitalization: TextCapitalization.sentences,
                            name: "link_text_sa",
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Linkin teksti'.t(context),
                                hintText: "Saameksi".t(context),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: const OutlineInputBorder()),
                          ),
                          const FormInfoText(text: "Kirjoita linkin teksti"),
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
                            onChanged: (val) {
                              if (val != null) {
                                NotificationBuilderState s =
                                    context.read<NotificationBuilderState>();
                                s.notification.linkTextEn = val;
                                s.notify();
                              }
                            },
                            textCapitalization: TextCapitalization.sentences,
                            name: "link_text_en",
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Linkin teksti'.t(context),
                                hintText: "Englanniksi".t(context),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: const OutlineInputBorder()),
                          ),
                          const FormInfoText(text: "Kirjoita linkin teksti"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                  width: 25,
                ),
                FormBuilderTextField(
                  onChanged: (val) {
                    if (val != null) {
                      NotificationBuilderState s =
                          context.read<NotificationBuilderState>();
                      s.notification.linkUrl = val;
                      s.notify();
                    }
                  },
                  textCapitalization: TextCapitalization.sentences,
                  name: "link_url",
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Linkin osoite'.t(context),
                      hintText: "Osoite".t(context),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: const OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.url(
                        requireProtocol: true, errorText: "Url must be valid")
                  ]),
                ),
                const FormInfoText(text: "Kirjoita linkin osoite"),
                FormBuilderCheckbox(
                    onChanged: (val) {
                      if (val != null) {
                        NotificationBuilderState s =
                            context.read<NotificationBuilderState>();
                        s.notification.displayInFrontPage = val;
                        s.notify();
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    name: "display_frontpage",
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Padding(
                        padding: EdgeInsets.zero,
                        child: Text("Näytä ilmoitus etusivulla".t(context)))),
                FormBuilderCheckbox(
                    onChanged: (val) {
                      if (val != null) {
                        NotificationBuilderState s =
                            context.read<NotificationBuilderState>();
                        s.notification.displayInList = val;
                        s.notify();
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    name: "enabled",
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Padding(
                        padding: EdgeInsets.zero,
                        child: Text("Näytä listassa".t(context))))
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
                    Map<String, dynamic> temp = Map.from(formData);
                    if (notification?.id != null) {
                      temp["notification_id"] = notification!.id.toString();
                    }
                    onSubmit(temp);
                    formKey.value.currentState?.reset();

                    // onSubmit(formData);
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
            if (onDelete != null &&
                notification != null &&
                notification?.id != null)
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  AlertHelper.displayConfirmAlert(
                      "Haluatko poistaa ilmoituksen?", context, onConfirm: () {
                    Navigator.of(context).pop();
                    onDelete!(notification!.id!);
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
