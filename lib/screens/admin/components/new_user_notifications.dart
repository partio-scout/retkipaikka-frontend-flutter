import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/alert_helper.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';

class NewUserNotifications extends HookWidget {
  NewUserNotifications({Key? key, required this.user}) : super(key: key);
  final UserApi userApi = UserApi();
  final AdminUser? user;
  @override
  Widget build(BuildContext context) {
    var groupValue = useState<String>(user?.userNotifications ?? "none");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ilmoitukset uusista käyttäjistä",
          style: TextStyle(fontSize: 20),
        ),
        ListTile(
          title: const Text("Ei ilmoituksia"),
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
          title: const Text("Kaikki ilmoitukset"),
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
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            Map<String, dynamic> payload = {
              "user_notifications": groupValue.value
            };
            userApi.modifyOwnUserSettings(user!.id, payload).then((value) {
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
          child: const Text(
            "Tallenna",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
