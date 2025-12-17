import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_provider.dart';
import 'package:givt_driver_app/Views/Authentications/signUpPage/signupModal.dart';
import 'package:givt_driver_app/Utils/api_client.dart';
import 'package:givt_driver_app/Utils/api_constant.dart';

class ApiRepository {
  // mobile Registration
  ///

  static Future<Response<dynamic>?> mobileRegistration({String? mobile}) async {
    final result = await ApiClient().postApi({
      'mobile_number': mobile,
    }, url: ApiConstant.mobileRegistrationApi);
    return result;
  }

  // Save PIN

  static Future<Response<dynamic>?> savePinRepository({String? pin}) async {
    // Assuming pin is used as mobile here for example

    final result = await ApiClient().postApi({
      'pin': pin,
    }, url: ApiConstant.savePinApi);
    return result;
  }

  /// Signup

  static Future<Response<dynamic>?> signUpRepository(
    SignupData signupData,
  ) async {
    final date = DateTime.parse(signupData.dateofbirth!);
    final formatted =
        "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
    final result = await ApiClient().postApi(
      {
        "name": signupData.fullname,
        "email": signupData.email,
        "gender": signupData.gender,
        "dob": formatted,
        "user_role": signupData.userRole,
        // Only include token if needed by your API!
        // "token": signupData.token,
      },
      url: ApiConstant.signUpApi,
      // If token is needed as header, pass as optional param (see previous answers)
      // token: signupData.token,
    );
    return result;
  }

  static Future<Response<dynamic>?> validateuserbyPIN({String? pin}) async {
    // Assuming pin is used as mobile here for example

    final result = await ApiClient().postApi({
      'pin': pin,
    }, url: ApiConstant.verifyUserPinApi);
    return result;
  }

  static Future<String?> refreshTokenApi({required String refreshToken}) async {
    // This should call your actual refresh token endpoint
    final result = await ApiClient().postApi(
      {},
      url: ApiConstant
          .refreshTokenApi, // Make sure this is the actual refresh endpoint!
    );
    if (result != null && result.data != null && result.data['token'] != null) {
      final box = GetStorage();
      box.write('token', result.data['token']);
      // Optionally, update the refresh_token too if your API returns a new one
      if (result.data['refresh_token'] != null) {
        box.write('refresh_token', result.data['refresh_token']);
      }
      return result.data['token'];
    }
    return null;
  }

  //Forgot Pin

  static Future<Response<dynamic>?> generateForgotOTP() async {
    // Assuming pin is used as mobile here for example

    final result = await ApiClient().postApi(
      {},
      url: ApiConstant.generatefortgotOTPApi,
    );
    return result;
  }

  /// validate Forgot API

  static Future<Response<dynamic>?> validateforgot(String pin) async {
    // Assuming pin is used as mobile here for example

    final result = await ApiClient().postApi({
      'otp': pin,
    }, url: ApiConstant.validateforgotOTPApi);
    return result;
  }

  ///
  /// Change PIN
  static Future<Response<dynamic>?> changePin({
    String? oldPin,
    String? newPin,
  }) async {
    // Assuming pin is used as mobile here for example

    final result = await ApiClient().postApi({
      'old_pin': oldPin,
      'pin': newPin,
    }, url: ApiConstant.changePin);
    return result;
  }

  /// get All categories
  static Future<Response<dynamic>?> getAllCategories() async {
    var result = ApiClient().getApi(url: ApiConstant.getAllCategories);

    return result;
  }

  /// get All vouchers
  static Future<Response<dynamic>?> getAllVouchers({String? categoryId}) async {
    var result = ApiClient().getApi(
      url: ApiConstant.getVouchers + "?category_id=$categoryId",
    );

    return result;
  }
}
