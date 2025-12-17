import 'package:flutter/widgets.dart';

class DatabaseProvider with ChangeNotifier {
  String? _gender;

  String? get gender => _gender;

  set gender(String? value) {
    _gender = value;
    notifyListeners();
  }

 


}
