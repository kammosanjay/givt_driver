import 'package:flutter/widgets.dart';

class Language with ChangeNotifier {
  static const List<Map<String, dynamic>> languages = [
    {"name": "English", 'locale': 'en'},
    {'name': "Arabic", 'locale': 'ar'},
  ];

  Locale selectectLocale = Locale('en');

  //

  void changeLanguage(String language) {
    selectectLocale = Locale(language);

    notifyListeners();
  }
}
