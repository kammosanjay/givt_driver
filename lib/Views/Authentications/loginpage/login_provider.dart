// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import 'package:get_storage/get_storage.dart';
import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
import 'package:givt_driver_app/Views/Authentications/OTP/pin_generate_screen.dart';

import 'package:givt_driver_app/Views/Authentications/loginpage/login_response_modal.dart';

import 'package:givt_driver_app/Views/Authentications/signUpPage/signupModal.dart';

import 'package:givt_driver_app/Utils/api_repository.dart';

import 'package:dio/dio.dart';
import 'package:givt_driver_app/Utils/token.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final box = GetStorage();

  String? storedEmail;
  String? storedPassword;
  String? storedName;
  bool isRememberMeChecked = false;
  bool isLoading = false;
  bool isWorking = false;
  String? error;
  dynamic response;
  String? message;

  String? userExitMessage;
  Dio dio = Dio();

  String? userMobile;
  String? token;
  String? verificationId;
  var saveNumber;
  int count = 0;

  bool isVerified = false;
  LoginProvider() {}

  final FirebaseAuth _auth = FirebaseAuth.instance;

  int submitApi() {
    count++;
    return count;
  }

  Future<void> firebasePhoneVerification(
    String phone,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      FirebaseAuth.instance.setLanguageCode('en');
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        timeout: const Duration(seconds: 60),

        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          isLoading = false;
          notifyListeners();
          debugPrint("✅ Auto verified and logged in!");
        },

        verificationFailed: (FirebaseAuthException e) {
          isLoading = false;
          notifyListeners();
          debugPrint("❌ Verification failed: ${e.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Verification failed")),
          );
        },

        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
          box.write('firebaseToken', verId);

          userMobile = phone;
          isLoading = false;
          notifyListeners();

          box.write('user_mobile', phone);
          debugPrint("📩 OTP sent to $phone");

          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<RouteProvider>().navigateTo(
              '/firebaseOtpScreen',
              context,
            );
          });
          notifyListeners();
        },

        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
          isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("🔥 Error sending OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP. Please try again.")),
      );
    }
  }

  Future<bool> verifyOtp(String smsCode, BuildContext context) async {
    verificationId ??= box.read('verificationId');

    if (verificationId != null) {
      try {
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: smsCode,
        );

        await _auth.signInWithCredential(credential);
        isVerified = true;
        notifyListeners();

        debugPrint("🎉 OTP Verified Successfully, User Logged In");
        // Return true to indicate verification succeeded.
        return true;
      } on FirebaseAuthException catch (e) {
        isVerified = false;
        notifyListeners();

        String errorMsg = "Invalid OTP. Please try again.";
        if (e.code == 'session-expired') {
          errorMsg = "Session expired. Please resend OTP.";
        } else if (e.code == 'invalid-verification-code') {
          errorMsg = "Wrong OTP entered.";
        }

        debugPrint("❌ OTP verification failed: ${e.message}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMsg)));
        // Return false to indicate verification failed.
        return false;
      }
    } else {
      isVerified = false;
      notifyListeners();
      debugPrint("❌ No verificationId found! Cannot verify OTP.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No verificationId found! Please restart login."),
        ),
      );
      return false;
    }
  }

  
  
  Future<Map<String, dynamic>?> saveSignupData(SignupData signupData) async {
    isWorking = true;
    notifyListeners();
    try {
      final response = await ApiRepository.signUpRepository(signupData);
      isWorking = false; // << Make sure this is here for both branches
      notifyListeners();

      if (response != null) {
        debugPrint("Signup API called successfully");
        message = response.data['message'];
        return response.data as Map<String, dynamic>;
      } else {
        debugPrint("Signup API call failed");
        return null;
      }
    } catch (e) {
      isWorking = false; // << Also needed in catch
      notifyListeners();
      debugPrint("Error calling signup API: $e");
      return null;
    }
  }

  // login by mobile number

  Future<dynamic> loginByMobileNumber(
    String mobileNumber,
    BuildContext context,
  ) async {
    try {
      final response = await ApiRepository.mobileRegistration(
        mobile: mobileNumber,
      );

      if (response == null || response.data == null) {
        debugPrint("No response from API");
        return;
      }

      LoginReponse apiResponse = LoginReponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      final token = apiResponse.token;

      if (token != null && token.isNotEmpty) {
        box.write('token', token);
      }
      notifyListeners();

      String message = response.data['message'];

      if (message == 'Mobile Number already exists') {
        context.read<RouteProvider>().navigateReplace('/home', context);
      }

      if (response.data['success'] == true) {
        debugPrint('Login successful: $message');
        context.read<RouteProvider>().navigateReplace('/signUpPage', context);
        // Or with Navigator:
        // Navigator.pushReplacementNamed(context, '/signUpPage');
      } else {
        debugPrint('Login failed: $message');
      }

      debugPrint('ApiResponse: ${response.data}');
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }

  Future<void> savePin(String pin, BuildContext context) async {
    // Here you would typically save the PIN securely

    debugPrint("Saved PIN: $pin");

    final response = await ApiRepository.savePinRepository(pin: pin);
    box.write('user_pin', pin);
    // Navigate to home page after saving PIN
    if (pin != null || pin.isNotEmpty) {
      print("Save PIN response==>$response");
      FlutterToastr.show(
        response!.data['message'],
        context,
        duration: FlutterToastr.lengthShort,
        position: FlutterToastr.bottom,
        backgroundColor: Colors.green,
      );
      context.read<RouteProvider>().navigateReplace('/home', context);
    } else {
      FlutterToastr.show(
        response!.data['message'],
        context,
        duration: FlutterToastr.lengthShort,
        position: FlutterToastr.bottom,
        backgroundColor: Colors.green,
      );
    }
  }

  ///
  ///
  ///vefigy user pin
  Future<void> verifyPin(String pin, BuildContext context) async {
    // Here you would typically save the PIN securely

    final storagetoken = box.read('token');
    final response = await ApiRepository.validateuserbyPIN(pin: pin);

    FlutterToastr.show(
      response!.data['message'],
      context,
      duration: FlutterToastr.lengthShort,
      position: FlutterToastr.bottom,
      backgroundColor: Colors.green,
    );
    print("Save PIN response==>$response");

    // Navigate to home page after saving PIN
    context.read<RouteProvider>().navigateTo('/home', context);
  }

  //
  Future<void> verifyUserPin(String pin, BuildContext context) async {
    final response = await ApiRepository.validateuserbyPIN(pin: pin);
    debugPrint("PinPageResponse=> $response");

    userExitMessage = response!.data['message'];
    notifyListeners();

    if (response.data['success'] == true) {
      FlutterToastr.show(
        response.data['message'],
        context,
        duration: FlutterToastr.lengthLong,
        position: FlutterToastr.bottom,
        backgroundColor: Colors.green,
      );

      context.read<RouteProvider>().navigateTo('/home', context);
      return;
    } else {
      debugPrint('testing2');
      FlutterToastr.show(
        response.data['message'],
        context,
        duration: FlutterToastr.lengthShort,
        position: FlutterToastr.bottom,
        backgroundColor: Colors.red,
      );
    }
    return;
  }

  Future<void> logout(BuildContext context) async {
    context.read<RouteProvider>().navigateReplace('/loginbyPin', context);
  }

  /// Generate Forgot PIN

  Future<void> generateForgotPIN() async {
    final response = await ApiRepository.generateForgotOTP();
    if (response != null) {
      Map<String, dynamic> jsonRes = response.data;
      print("forgotpinApihitted=> $jsonRes");
    }
  }
  // Validate forgot OTP PIN

  Future<void> validateForgotOTP(String? pin, BuildContext context) async {
    final response = await ApiRepository.validateforgot(pin!);
    if (response != null) {
      Map<String, dynamic> jsonRes = response.data;
      bool check = jsonRes['success'];
      message = jsonRes['message'];

      if (check) {
        FlutterToastr.show(
          message!,
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
          backgroundColor: Colors.green,
        );
        context.read<RouteProvider>().navigateTo('/pinPage', context);
      } else {
        FlutterToastr.show(
          message!,
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
          backgroundColor: Colors.red,
        );
      }

      print("forgotpinApihitted=> $jsonRes");
    }
  }

  /// changePin

  Future<void> changePinbyUser(
    BuildContext context, {
    String? oldpin,
    String? newpin,
  }) async {
    final response = await ApiRepository.changePin(
      newPin: newpin,
      oldPin: oldpin,
    );
    try {
      if (response!.statusCode == 201) {
        if (response != null && response.data['success'] == true) {
          Map<String, dynamic> jsonRes = response.data;
          message = jsonRes['message'];
          notifyListeners();

          FlutterToastr.show(
            message!,
            context,
            duration: FlutterToastr.lengthLong,
            position: FlutterToastr.center,
            backgroundColor: Colors.green,
          );
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } else {
          FlutterToastr.show(
            message!,
            context,
            duration: FlutterToastr.lengthLong,
            position: FlutterToastr.center,
            backgroundColor: Colors.redAccent,
          );
        }
      }
    } catch (e) {
      FlutterToastr.show(
        e.toString(),
        context,
        duration: FlutterToastr.lengthLong,
        position: FlutterToastr.center,
        backgroundColor: Colors.redAccent,
      );
    }
  }
}
