import 'package:flutter/material.dart';

const int desktopScreenSize = 1366;
const int tabletScreenSize = 768;
const int mobileScreenSize = 360;
const int customScreenSize = 1100;

class Responsive extends StatelessWidget {
  /// Responsive widget can be used by defining widgets for desktop
  /// and mobile or tablet in constructor - it will render the correct widget
  /// based on screen size.
  ///
  /// Optionally static methods can be used to determine screen size
  final Widget desktop;
  final Widget? tablet;
  final Widget mobile;

  const Responsive({
    Key? key,
    required this.desktop,
    this.tablet,
    required this.mobile,
  }) : super(key: key);

  static bool isDesktop(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= desktopScreenSize;
  }

  static bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= tabletScreenSize && width < desktopScreenSize;
  }

  static bool isMobile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < tabletScreenSize;
  }

  static bool isCustomSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= tabletScreenSize && width < desktopScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      if (width >= desktopScreenSize) {
        return desktop;
      } else if (width < desktopScreenSize && width >= tabletScreenSize) {
        return tablet ?? desktop;
      } else {
        return mobile;
      }
    });
  }
}
