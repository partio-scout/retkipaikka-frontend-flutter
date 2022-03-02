import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/screens/main/front_page_screen.dart';
import 'package:retkipaikka_flutter/screens/main_container.dart';
import 'package:retkipaikka_flutter/screens/notifications/notification_screen.dart';
import 'package:routemaster/routemaster.dart';

class AdminRoutes {
  static const adminRoot = "/admin";
  static const adminNew = "/admin/new-locations";
  static const adminBrowse = "/admin/browse-locations";
  static const adminFilter = "/admin/filters";
  static const adminSettings = "/admin/settings";
  static const admingSettings = "/admin/notifications";
}

class UserRoutes {
  static const root = "/";
  static const locations = "/locations";
  static const notifications = "/notifications";
  static const login = "/login";
  static const signUp = "/sign-up";
}

class AppPages {
  static RouteMap adminRoutes() {
    return RouteMap(
        // onUnknownRoute: (route) => const Redirect(AppRoutes.dashboard),
        routes: {
          UserRoutes.root: (routeData) {
            return const TabPage(
              backBehavior: TabBackBehavior.history,
              child: MainContainer(),
              paths: [UserRoutes.locations, UserRoutes.notifications],
            );
          },
          UserRoutes.locations: (routeData) {
            return MaterialPage(child: FrontPageScreen());
          },
          UserRoutes.notifications: (routeData) {
            return const MaterialPage(child: NotificationScreen());
          },
        });
  }

  static RouteMap userRoutes() {
    return RouteMap(
        // onUnknownRoute: (route) => const Redirect(AppRoutes.dashboard),
        routes: {
          UserRoutes.root: (routeData) {
            return const TabPage(
              backBehavior: TabBackBehavior.history,
              child: MainContainer(),
              paths: [UserRoutes.locations, UserRoutes.notifications],
            );
          },
          UserRoutes.locations: (routeData) {
            return MaterialPage(child: FrontPageScreen());
          },
          UserRoutes.notifications: (routeData) {
            return const MaterialPage(child: NotificationScreen());
          },
        });
  }
}
