// route_provider.dart
import 'package:flutter/material.dart';
import 'package:givt_driver_app/Views/home/dashboard.dart';

class RouteProvider with ChangeNotifier {
  String _currentRoute = '/';

  String get currentRoute => _currentRoute;

  Future<dynamic> navigateTo(
    String routeName,
    BuildContext context, {
    Object? arguments,
  }) {
    _currentRoute = routeName;
    notifyListeners();
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    ); // 🔁 return the future
  }

  void navigateReplace(String routeName, BuildContext context) {
    _currentRoute = routeName;
    notifyListeners();
    Navigator.pushReplacementNamed(context, routeName);
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  Future<dynamic> navigate(BuildContext context, Widget classname) {
    return Navigator.push(
      context,
      
      MaterialPageRoute(builder: (context) => classname,),
    );
  }
}
