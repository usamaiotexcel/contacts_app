import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 900;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;

  static EdgeInsets horizontalPadding(
    BuildContext context, {
    bool vertical = false,
  }) {
    if (isDesktop(context)) {
      return EdgeInsets.symmetric(horizontal: 250, vertical: vertical ? 30 : 0);
    }
    if (isTablet(context)) {
      return EdgeInsets.symmetric(horizontal: 50, vertical: vertical ? 15 : 0);
    }
    return const EdgeInsets.symmetric(horizontal: 16);
  }

  static double fontSize(
    BuildContext context, {
    double mobile = 14,
    double tablet = 16,
    double desktop = 18,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }
}
