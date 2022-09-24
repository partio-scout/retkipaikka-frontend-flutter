import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/custom_autocomplete.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/models/abstract_filter_model.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/models/geo_area_model.dart';
import 'package:retkipaikka_flutter/screens/admin/components/admin_tag_bar.dart';

class NewLocationNotifications extends HookWidget {
  NewLocationNotifications({Key? key, required this.user}) : super(key: key);
  final String kGroupValue = "LOCATION_GROUP";
  final UserApi userApi = ApiService().userApi;
  final AdminUser? user;
  @override
  Widget build(BuildContext context) {
    var groupValue = useState<String>(user?.notifications ?? "none");
    var selectedRegions = useState<List<AbstractFilter>>(user?.regions != null
        ? user!.regions
            .map((e) => GeoArea(
                id: e["region_id"],
                type: FilterType.region,
                name: e["object_name"]))
            .toList()
        : []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ilmoitukset uusista retkipaikoista".t(context),
          style: const TextStyle(fontSize: 20),
        ),
        ListTile(
          title: Text("Ei ilmoituksia".t(context)),
          leading: Radio<String>(
            value: "none",
            groupValue: groupValue.value,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (String? value) {
              if (value != null) {
                groupValue.value = value;
              }
            },
          ),
        ),
        ListTile(
          title: Text("Kaikki ilmoitukset".t(context)),
          leading: Radio<String>(
            value: "all",
            groupValue: groupValue.value,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (String? value) {
              if (value != null) {
                groupValue.value = value;
              }
            },
          ),
        ),
        ListTile(
          title: Text("Valitse maakunnat".t(context)),
          leading: Radio<String>(
            value: "select",
            groupValue: groupValue.value,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (String? value) {
              if (value != null) {
                groupValue.value = value;
              }
            },
          ),
        ),
        if (groupValue.value == "select") ...[
          CustomAutocomplete(
            data: context.select((FilteringState s) => s.allRegions),
            onValueSelect: (value) {
              List<AbstractFilter> tempList = List.from(selectedRegions.value);
              if (tempList.indexWhere((element) => element.id == value.id) ==
                  -1) {
                tempList.add(value);
                selectedRegions.value = tempList;
              }
            },
            disabled: false,
            title: "Maakunnat".t(context),
          ),
          const SizedBox(
            height: 15,
          ),
          AdminTagBar(
            tags: selectedRegions.value,
            onTagPressed: (tag) {
              List<AbstractFilter> tempList = selectedRegions.value
                  .where((element) => element.id != tag.id)
                  .toList();
              selectedRegions.value = tempList;
            },
          ),
        ],
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: (groupValue.value == "select" &&
                  selectedRegions.value.isEmpty)
              ? null
              : () async {
                  List<int> regs = groupValue.value == "select"
                      ? selectedRegions.value.map((elem) => elem.id).toList()
                      : [];
                  userApi
                      .modifyUserNotifications(user!.id, groupValue.value, regs)
                      .then((value) {
                    return userApi.fetchSingleUser(user!.id, user!.token);
                  }).then((value) {
                    context.read<AppState>().handleAfterUserUpdate(value);
                  }).then(((value) {
                    AlertHelper.displaySuccessAlert(
                        "Ilmoitusasetukset päivitetty", context);
                  })).catchError((err) {
                    AlertHelper.displayErrorAlert(err, context);
                  });
                },
          child: Text(
            "Tallenna".t(context),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
