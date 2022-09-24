import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/constants.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';

import 'package:retkipaikka_flutter/helpers/api_service.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';
import 'package:retkipaikka_flutter/helpers/locales/app_localization_delegate.dart';
import 'package:retkipaikka_flutter/helpers/locales/smn_intl.dart';
import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/routes.dart';
import 'package:routemaster/routemaster.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class RetkipaikkaApp extends StatelessWidget {
  const RetkipaikkaApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Partion retkipaikat',
      debugShowCheckedModeBanner: false,
      supportedLocales: kSupportedLocales.keys.map((locale) => Locale(locale)),
      locale: context.select((AppState a) => a.appLocale),
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SmnMaterialLocalizations.delegate
      ],
      darkTheme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme()
              .copyWith(backgroundColor: const Color(0xFF424242)),
          primaryColor: const Color(0xFF253764),
          colorScheme: const ColorScheme.dark(
              primary: Color(0xFF28aae1), secondary: Color(0xFF253764)),
          primaryColorLight: const Color(0xFF28aae1)),
      themeMode: context.select((AppState a) {
        if (a.darkTheme) {
          return ThemeMode.dark;
        }
        return ThemeMode.light;
      }),
      theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF253764),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF253764),
            secondary: Color(0xFF28aae1),
          ),
          primaryColorLight: const Color(0xFF28aae1)),
      builder: (context, child) {
        return AppWrapper(child: child);
      },
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        return AppPages.appRoutes(context);
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

class AppWrapper extends HookWidget {
  const AppWrapper({Key? key, required this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    var isLoading = useState<bool>(true);
    useEffect(() {
      Future.microtask(() async {
        String? tokenFromPrefs = await SharedPreferencesHelper.getSavedToken();

        if (tokenFromPrefs != null) {
          //isLoading.value = true;
          ApiService()
              .userApi
              .checkTokenValidity(tokenFromPrefs)
              .then((value) async {
            if (value) {
              AdminUser? user = await SharedPreferencesHelper.getSavedUser();
              if (user != null) {
                context.read<AppState>().setLogin(user);
              }
            } else {
              await context.read<AppState>().handleAfterLogout();
            }
          }).catchError((err) {
            if (kDebugMode) {
              print(err);
            }
          }).whenComplete(() {
            isLoading.value = false;
          });
        } else {
          isLoading.value = false;
        }
      });
      return null;
    }, []);
    return isLoading.value
        ? Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: double.infinity,
            width: double.infinity,
            child: const AppSpinner())
        : child ?? const SizedBox();
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
