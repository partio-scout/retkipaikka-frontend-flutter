import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retkipaikka_flutter/controllers/app_state.dart';
import 'package:retkipaikka_flutter/helpers/components/app_spinner.dart';
import 'package:retkipaikka_flutter/screens/admin/admin_filters_screen.dart'
    deferred as admin_filters;
import 'package:retkipaikka_flutter/screens/admin/admin_locations_screen.dart'
    deferred as admin_locations;
import 'package:retkipaikka_flutter/screens/admin/admin_notifications_screen.dart'
    deferred as admin_notifications;
import 'package:retkipaikka_flutter/screens/admin/admin_settings_screen.dart'
    deferred as admin_settings;
import 'package:retkipaikka_flutter/screens/login/login_screen.dart'
    deferred as login_screen;
import 'package:retkipaikka_flutter/screens/main/front_page_screen.dart';
import 'package:retkipaikka_flutter/screens/main_container.dart';
import 'package:retkipaikka_flutter/screens/notifications/notification_screen.dart'
    deferred as notification_screen;

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
          child: MainContainerSinglePage(
            child: FrontPageScreen(),
          ),
        );
      },
      UserRoutes.notifications: (routeData) {
        Future<void> loadedFile = notification_screen.loadLibrary();

        return CustomMaterialPage(
          child: MainContainerSinglePage(
            child: FutureBuilder(
              future: loadedFile,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? notification_screen.NotificationsScreen()
                    : Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: double.infinity,
                        width: double.infinity,
                        child: const AppSpinner());
              },
            ),
          ),
        );
      },
      UserRoutes.login: (routeData) {
        Future<void> loadedFile = login_screen.loadLibrary();

        return CustomMaterialPage(
          child: MainContainerSinglePage(
            child: FutureBuilder(
              future: loadedFile,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? login_screen.LoginScreen(
                        isLoginPage: true,
                      )
                    : Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: double.infinity,
                        width: double.infinity,
                        child: const AppSpinner());
              },
            ),
          ),
        );
      },
      UserRoutes.signUp: (routeData) {
        Future<void> loadedFile = login_screen.loadLibrary();
        return CustomMaterialPage(
          child: MainContainerSinglePage(
            child: FutureBuilder(
              future: loadedFile,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? login_screen.LoginScreen(
                        isLoginPage: false,
                      )
                    : Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: double.infinity,
                        width: double.infinity,
                        child: const AppSpinner());
              },
            ),
          ),
        );
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
        Future<void> loadedFile = admin_locations.loadLibrary();
        return privateRoute(
            CustomMaterialPage(
                child: FutureBuilder(
                    future: loadedFile,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? admin_locations.AdminLocationsScreen(
                              displayOnlyNew: true,
                            )
                          : Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: double.infinity,
                              width: double.infinity,
                              child: const AppSpinner());
                    })),
            context);
      },
      AdminRoutes.adminBrowse: (routeData) {
        Future<void> loadedFile = admin_locations.loadLibrary();
        return privateRoute(
            CustomMaterialPage(
                child: FutureBuilder(
                    future: loadedFile,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? admin_locations.AdminLocationsScreen(
                              displayOnlyNew: false,
                            )
                          : Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: double.infinity,
                              width: double.infinity,
                              child: const AppSpinner());
                    })),
            context);
      },
      AdminRoutes.adminFilter: (routeData) {
        Future<void> loadedFile = admin_filters.loadLibrary();
        return privateRoute(
            CustomMaterialPage(
                child: FutureBuilder(
                    future: loadedFile,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? admin_filters.AdminFiltersScreen()
                          : Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: double.infinity,
                              width: double.infinity,
                              child: const AppSpinner());
                    })),
            context);
      },
      AdminRoutes.adminNotifications: (routeData) {
        Future<void> loadedFile = admin_notifications.loadLibrary();
        return privateRoute(
            CustomMaterialPage(
                child: FutureBuilder(
                    future: loadedFile,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? admin_notifications.AdminNotificationsScreen()
                          : Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: double.infinity,
                              width: double.infinity,
                              child: const AppSpinner());
                    })),
            context);
      },
      AdminRoutes.adminSettings: (routeData) {
        Future<void> loadedFile = admin_settings.loadLibrary();
        return privateRoute(
            CustomMaterialPage(
                child: FutureBuilder(
                    future: loadedFile,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? admin_settings.AdminSettingsScreen()
                          : Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: double.infinity,
                              width: double.infinity,
                              child: const AppSpinner());
                    })),
            context);
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
