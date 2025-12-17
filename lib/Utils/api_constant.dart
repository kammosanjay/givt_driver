class ApiConstant {

  ///
  ///
  /// Base URL
  static String baseUrl = 'https://givt.softgen.co.in/api/v1/';
  /// Mobile Registration API
  static String mobileRegistrationApi = '${baseUrl}mobile_registration';
  /// Signup API
  static String signUpApi = '${baseUrl}save-user-details';
  /// Save PIN API
  static String savePinApi = '${baseUrl}save-user-pin';
  /// verify user PIN API
  static String verifyUserPinApi = '${baseUrl}validate-user-pin';
  /// refresh token API
  static String refreshTokenApi = '${baseUrl}refresh-jwt-token';
  /// forgotPIN Api
  static String generatefortgotOTPApi = '${baseUrl}generate-password-otp';
  /// 
  static String validateforgotOTPApi = '${baseUrl}validate-password-otp';
  ///
  static String forgotPinApi = '${baseUrl}forgot-user-pin';
  ///
  static String getAllCategories = '${baseUrl}get-all-categories';
  ///
  static String getVouchers = '${baseUrl}get-vouchers-list';
  ///
  static String changePin = '${baseUrl}change-user-pin';
}
