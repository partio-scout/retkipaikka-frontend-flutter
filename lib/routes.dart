import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/screens/admin/admin_filters_screen.dart';
import 'package:retkipaikka_flutter/screens/admin/admin_locations_screen.dart';
import 'package:retkipaikka_flutter/screens/admin/admin_notifications_screen.dart';
import 'package:retkipaikka_flutter/screens/admin/admin_settings_screen.dart';
import 'package:retkipaikka_flutter/screens/login/login_screen.dart';
import 'package:retkipaikka_flutter/screens/main/front_page_screen.dart';
import 'package:retkipaikka_flutter/screens/main_container.dart';
import 'package:retkipaikka_flutter/screens/notifications/notification_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'package:provider/provider.dart';

class AdminRoutes {
  static const adminRoot = "/admin";
  static const adminNew = "/admin/new-locations";
  static const adminBrowse = "/admin/browse-locations";
  static const adminFilter = "/admin/filters";
  static const adminSettings = "/admin/settings";
  static const adminNotifications = "/admin/notifications";
}

class UserRoutes {
  static const locations = "/";
  static const notifications = "/notifications";
  static const login = "/login";
  static const signUp = "/sign-up";
}

class AppPages {
  static Page privateRoute(Page route, BuildContext context) {
    if (!context.read<AppState>().isLoggedIn) {
      return const Redirect(UserRoutes.login);
    }

    return route;
  }

  static RouteMap appRoutes(BuildContext context) {
    return RouteMap(routes: {
      UserRoutes.locations: (routeData) {
        return const CustomMaterialPage(
            child: MainContainerSinglePage(child: FrontPageScreen()));
      },
      UserRoutes.notifications: (routeData) {
        return const CustomMaterialPage(
            child: MainContainerSinglePage(child: NotificationScreen()));
      },
      UserRoutes.login: (routeData) {
        return const CustomMaterialPage(
            child: MainContainerSinglePage(
                child: LoginScreen(
          isLoginPage: true,
        )));
      },
      UserRoutes.signUp: (routeData) {
        return const CustomMaterialPage(
            child: MainContainerSinglePage(
                child: LoginScreen(
          isLoginPage: false,
        )));
      },
      AdminRoutes.adminRoot: (routeData) {
        return privateRoute(
            TabPage(
                pageBuilder: (child) => CustomMaterialPage(child: child),
                paths: const [
                  AdminRoutes.adminNew,
                  AdminRoutes.adminBrowse,
                  AdminRoutes.adminFilter,
                  AdminRoutes.adminNotifications,
                  AdminRoutes.adminSettings,
                ],
                backBehavior: TabBackBehavior.history,
                child: const AdminMainContainer()),
            context);
      },
      AdminRoutes.adminNew: (routeData) {
        return privateRoute(
            CustomMaterialPage(
                child: AdminLocationsScreen(displayOnlyNew: true)),
            context);
      },
      AdminRoutes.adminBrowse: (routeData) {
        return privateRoute(
            CustomMaterialPage(
                child: AdminLocationsScreen(displayOnlyNew: false)),
            context);
      },
      AdminRoutes.adminFilter: (routeData) {
        return privateRoute(
            CustomMaterialPage(child: AdminFiltersScreen()), context);
      },
      AdminRoutes.adminNotifications: (routeData) {
        return privateRoute(
            const CustomMaterialPage(child: AdminNotificationsScreen()),
            context);
      },
      AdminRoutes.adminSettings: (routeData) {
        return privateRoute(
            const CustomMaterialPage(child: AdminSettingsScreen()), context);
      },
    });
  }
}

class CustomMaterialPage extends TransitionBuilderPage<void> {
  const CustomMaterialPage({required Widget child, required})
      : super(child: child);

  @override
  PageTransition buildPushTransition(BuildContext context) {
    TargetPlatform platform = defaultTargetPlatform;
    if (kIsWeb ||
        [TargetPlatform.windows, TargetPlatform.macOS, TargetPlatform.linux]
            .contains(platform)) {
      // No push transition on web
      return PageTransition.none;
    }

    // Default Android fade upwards transition on push
    return PageTransition.fadeUpwards;
  }

  @override
  PageTransition buildPopTransition(BuildContext context) {
    TargetPlatform platform = defaultTargetPlatform;
    if (kIsWeb ||
        [TargetPlatform.windows, TargetPlatform.macOS, TargetPlatform.linux]
            .contains(platform)) {
      // No pop transition on web
      return PageTransition.none;
    }

    // Cupertino transition on pop
    return PageTransition.cupertino;
  }
}
