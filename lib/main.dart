import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/app.dart' deferred as app;

import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/notification_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';

import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';

import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
    // Add support for 120hz displays
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
  bool darkTheme = false;
  String? themeMode = await SharedPreferencesHelper.getThemeMode();

  if (themeMode != null) {
    darkTheme = themeMode == "true";
  }
  String? appLocale = await SharedPreferencesHelper.getLocale() ?? "fi";
  Locale locale = Locale(appLocale);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                AppState(darkTheme: darkTheme, appLocale: locale)),
        ChangeNotifierProvider(create: (context) => FilteringState()),
        ChangeNotifierProvider(create: (context) => NotificationState()),
        ChangeNotifierProvider(create: (context) => TripLocationState()),
      ],
      child: FutureBuilder(
          future: app.loadLibrary(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? app.RetkipaikkaApp()
                // Theme not loaded yet so can't use color from theme
                : Container(
                    color: darkTheme
                        ? const Color(0xFF303030)
                        : const Color(0xFFfafafa),
                    height: double.infinity,
                    width: double.infinity,
                    child: AppSpinner(
                      color: darkTheme
                          ? const Color(0xFF28aae1)
                          : const Color(0xFF253764),
                    ));
          })));
}
