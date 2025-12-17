import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashProvider with ChangeNotifier {
  /// Decodes token and prints remaining validity duration

  /// Initializes app - simulate splash delay, load token & navigate accordingly
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    final box = GetStorage();

    // Read token from local storage and assign
    final userToken = box.read('token');
    final userPin = box.read('user_pin');


    debugPrint('token in splash provider: $userToken');
    debugPrint(
      'user phone number in splash provider: ${box.read('user_mobile')}',
    );

    // Decode token validity info only after token is loaded

    // Navigate to Pin login only if token exists and is NOT expired
    if (userPin != null && userPin.isNotEmpty) {
      // Token expired — navigate to login page
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/loginbyPin');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/loginpage');
    }
  }
}
