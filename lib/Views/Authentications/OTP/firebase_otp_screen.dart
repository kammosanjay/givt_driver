import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_provider.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreenByfirease extends StatefulWidget {
  String? veriId;
  OtpScreenByfirease({super.key, this.veriId});

  @override
  State<OtpScreenByfirease> createState() => _OtpScreenByfireaseState();
}

class _OtpScreenByfireaseState extends State<OtpScreenByfirease>
    with SingleTickerProviderStateMixin {
  bool isShown = true;

  bool moveLeft = false;
  bool showText = false;
  TextEditingController otpcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();

    // Step 1: Move logo from center → left
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        moveLeft = true;
      });
    });

    // Step 2: Show text after logo finishes moving
    Future.delayed(const Duration(milliseconds: 1600), () {
      setState(() {
        showText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    // print("testing==>${from}");
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Stack(
            alignment: Alignment.center,
            children: [
              // Text (hidden initially, fades in later)
              AnimatedOpacity(
                opacity: showText ? 1 : 0,
                duration: const Duration(seconds: 1),
                child: Text(
                  "Givt, more than just a gift",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDarkEnabled
                        ? Colors.white
                        : MyColors.primaryColor,
                  ),
                ),
              ),
      
              // Moving logo
              AnimatedAlign(
                alignment: moveLeft ? Alignment.centerLeft : Alignment.center,
                duration: const Duration(milliseconds: 1600),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/couponlogo.png',
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 15),
            // height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade50,
                  // spreadRadius: 10,
                  blurRadius: 5,
                  offset: Offset(1, 1), // changes position of shadow
                ),
                BoxShadow(
                  color: Colors.red.shade50,
                  // spreadRadius: 10,
                  blurRadius: 5,
                  offset: Offset(-1, -1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'Enter OTP sent on your ',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: MyColors.bodyTextColor,
                  ),
                ),
                Text(
                  'mobile number',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: MyColors.bodyTextColor,
                  ),
                ),
      
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PinCodeTextField(
                    appContext: context,
      
                    controller: otpcontroller,
                    length: 6, // 6 digit OTP
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.scale,
                    cursorColor: Colors.black,
                    blinkWhenObscuring: true,
                    enablePinAutofill: true,
      
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
      
                      fieldHeight: 40,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.grey.shade50,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      selectedColor: Colors.amber,
                      activeColor: Colors.grey.shade400,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onChanged: (value) {
                      print("Current OTP value: $value");
                    },
                    onCompleted: (value) {
                      print("OTP Entered: $value");
                      // You can verify OTP here
                    },
                  ),
                ),
                // Spacer(),
                Text(
                  'Your privacy matters—enter the code for secure access',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: MyColors.hintColor,
                  ),
                ),
                SizedBox(height: 20),
                CustomWidgets.customButton(
                  context: context,
                  height: 60,
                  buttonName: 'Verify OTP',
                  onPressed: () async {
                    final otp = otpcontroller.text.trim();
                    final loginProvider = context.read<LoginProvider>();
      
                    final otpResult = await loginProvider.verifyOtp(
                      otp,
                      context,
                    );
                    // Assume 'verifyOtp' returns true for success, false for failure (modify your provider if needed)
                    if (otpResult == true) {
                      // await loginProvider.loginByMobileNumber(
                      //   loginProvider.userMobile!,
                      //   context,
                      // );
                      context.read<RouteProvider>().navigateReplace(
                        '/signUpPage',
                        context,
                      );
                    } else {
                      //   // Optionally, show error/snackbar for wrong OTP
                      //   debugPrint('OTP verification failed');
                    }
                  },
      
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  fontColor: Colors.white,
                  btnColor: MyColors.primaryColor,
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    // context.read<RouteProvider>().navigateTo(
                    //   '/signup',
                    //   context,
                    // );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignupPage()),
                    // );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't Received OTP ? ",
                      style: GoogleFonts.inter(
                        color: MyColors.hintColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Resend',
                          style: GoogleFonts.inter(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
