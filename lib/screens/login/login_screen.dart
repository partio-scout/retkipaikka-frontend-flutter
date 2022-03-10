import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/helpers/locales/translate.dart';
import 'package:retkipaikka_flutter/helpers/responsive.dart';
import 'package:retkipaikka_flutter/routes.dart';
import 'package:retkipaikka_flutter/screens/login/components/login_form.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:retkipaikka_flutter/screens/login/components/register_form.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key, required this.isLoginPage}) : super(key: key);
  final bool isLoginPage;
  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = Responsive.isDesktop(context)
        ? const EdgeInsets.symmetric(horizontal: 200)
        : const EdgeInsets.symmetric(horizontal: 10);
    return Padding(
      padding: padding,
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              isLoginPage ? LoginForm() : RegisterForm(),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  if (isLoginPage) {
                    Routemaster.of(context).push(UserRoutes.signUp);
                  } else {
                    Routemaster.of(context).push(UserRoutes.login);
                  }
                },
                child: Text(
                  isLoginPage
                      ? "Pyydä käyttöoikeuksia hallintasivulle".t(context)
                      : "Takaisin kirjautumiseen".t(context),
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 25)
            ]),
      ),
    );
  }
}
