import 'package:flutter/material.dart';

class MyColors {
  static const Color primaryColor = Color(0xFFF80000);
  static const Color secondaryColor = Color.fromRGBO(243, 233, 234, 1);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF1B1717);
  static const Color bodyTextColor = Color(0xFF494949);
  static const Color errorColor = Color(0xFFB00020);
  static const Color headLine = Color(0xFF1B202C);
  static const Color bodyText = Color(0xFF323845);
  static const Color disableBtn = Color(0xFFFFD6D6);
  static const Color appGrey = Color(0xFFE8EAED);
  static const Color appUrban = Color(0xFF2D3548);
  static const Color appSteelGrey = Color(0xFF6B7280);
  static const Color appaqua = Color(0xFF0FA4AF);
  static const Color appsolorAmber = Color(0xFFF5B400);
}

class AppColor {
  // Dynamic primary color from theme
  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color primaryCardColor(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color textColor(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.color ?? Color(0xFF333333);

  static Color errorColor(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color headingColor(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall?.color ?? Colors.black;

  static Color buttonColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
}
