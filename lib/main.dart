import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:provider/provider.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/controllers/filtering_state.dart';
import 'package:retkipaikka_flutter/controllers/notification_state.dart';
import 'package:retkipaikka_flutter/controllers/triplocation_state.dart';
import 'package:retkipaikka_flutter/helpers/api/user_api.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';
import 'package:retkipaikka_flutter/helpers/shared_preferences_helper.dart';
import 'package:retkipaikka_flutter/models/admin_model.dart';
import 'package:retkipaikka_flutter/routes.dart';

import 'package:routemaster/routemaster.dart';
//import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*   if (defaultTargetPlatform == TargetPlatform.android && !kIsWeb) {
    // Add support for 120hz displays
    //await FlutterDisplayMode.setHighRefreshRate();
  } */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => FilteringState()),
        ChangeNotifierProvider(create: (context) => NotificationState()),
        ChangeNotifierProvider(create: (context) => TripLocationState()),
      ],
      child: MaterialApp.router(
        title: 'Partion retkipaikat',
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale("fi"),
          Locale("en"),
          Locale("se"),
          Locale("smn")
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFF253764)),
        ),
        builder: (context, child) {
          return AppWrapper(child: child);
        },
        routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
          return AppPages.appRoutes(context);
        }),
        routeInformationParser: const RoutemasterParser(),
      ),
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
          UserApi().checkTokenValidity(tokenFromPrefs).then((value) async {
            if (value) {
              AdminUser? user = await SharedPreferencesHelper.getSavedUser();
              if (user != null) {
                context.read<AppState>().setLogin(user);
              }
            } else {
              await context.read<AppState>().handleAfterLogout();
            }
          }).catchError((err) {
            print(err);
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
            child: AppSpinner())
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
