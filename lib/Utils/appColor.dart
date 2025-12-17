import 'package:flutter/material.dart';

class MyColors {
  static const Color primaryColor = Color(0xFFE00024);
  static const Color secondaryColor = Color.fromRGBO(243, 233, 234, 1);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF1B1717);
  static const Color bodyTextColor = Color(0xFF494949);
  static const Color hintColor = Color(0xFF9E9E9E);

  static const Color errorColor = Color(0xFFB00020);
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
