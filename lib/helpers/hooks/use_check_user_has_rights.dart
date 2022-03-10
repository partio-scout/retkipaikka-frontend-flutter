import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

bool useCheckHasUserRights(BuildContext context,
    {List<String> allowedRoles = kSuperAdminRoles}) {
  AdminUser? user = context.read<AppState>().currentUser;

  var hasRights = useState<bool>(false);
  useEffect(() {
    if (user != null) {
      bool hasAllowedRole = user.roles
          .where((element) => allowedRoles.contains(element["name"]))
          .isNotEmpty;

      if (hasAllowedRole) {
        hasRights.value = true;
      }
    }
    return null;
  }, [user]);

  return hasRights.value;
}
