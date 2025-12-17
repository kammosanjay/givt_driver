import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricAuth {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateLocally() async {
    bool isAuthenticate = false;

    try {
       isAuthenticate = await auth.authenticate(
        localizedReason: "Authenticate for Using this App",
        options: AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        //
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        //
      }
    } catch (e) {
      isAuthenticate = false;
      print("Error: $e");
    }

    return isAuthenticate;
  }
}
