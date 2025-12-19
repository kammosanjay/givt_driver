import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
import 'package:givt_driver_app/Views/Authentications/OTP/biometric.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_provider.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinscreenLoginPage extends StatefulWidget {
  String? veriId;
  PinscreenLoginPage({super.key, this.veriId});

  @override
  State<PinscreenLoginPage> createState() => _PinscreenLoginPageState();
}

class _PinscreenLoginPageState extends State<PinscreenLoginPage>
    with SingleTickerProviderStateMixin {
  bool isShown = true;
  // AnimationController? _controller;
  bool moveLeft = false;
  bool showText = false;
  TextEditingController pinController = TextEditingController();
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

    // authInit();
  }

  void authInit() async {
    bool check = await BiometricAuth().authenticateLocally();
    if (check) {
      // ignore: use_build_context_synchronously
      context.read<RouteProvider>().navigateReplace('/home', context);
    } else {
      FlutterToastr.show(
        "Sorry ! I Did't get you",
        context,
        duration: FlutterToastr.lengthLong,
        position: FlutterToastr.center,
        backgroundColor: Colors.red,
      );
    }
  }

  // @override
  // void dispose() {
  //   _controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    // final from = ModalRoute.of(context)!.settings.arguments as String;
    // print("testing==>${from}");
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
              // height: MediaQuery.of(context).size.height * 0.6,
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
                  SizedBox(height: 10),
                  Text(
                    'Enter Your 6-digit PIN',
                    style: TextStyle(
                      fontFamily: 'san-serif',
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: MyColors.bodyTextColor,
                    ),
                  ),
                  Text(
                    'Access the App faster with a PIN',
                    style: TextStyle(
                      fontFamily: 'san-serif',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: MyColors.bodyTextColor,
                    ),
                  ),

                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: pinController,
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
                        print("Current Pin: $value");
                      },
                      onCompleted: (value) {
                        print("PIN Entered: $value");
                        // You can verify OTP here
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<RouteProvider>().navigateTo(
                        'forgotPIN',
                        context,
                      );
                      context.read<LoginProvider>().generateForgotPIN();
                    },
                    child: Text(
                      "Forgot PIN ?",
                      style: TextStyle(
                        fontFamily: 'san-serif',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MyColors.bodyTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Column(
                        children: [
                          IconButton.outlined(
                            onPressed: () async {
                              authInit();
                            },
                            icon: Icon(Icons.fingerprint_rounded),
                          ),
                          Text(
                            "FingerPrint",
                            style: TextStyle(
                              fontFamily: 'san-serif',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: MyColors.bodyTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          IconButton.outlined(
                            onPressed: () async {
                              authInit();
                            },
                            icon: Icon(Icons.face),
                          ),
                          Text(
                            "FaceID",
                            style: TextStyle(
                              fontFamily: 'san-serif',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: MyColors.bodyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Text(
                    'Your privacy matters—enter the code for secure access',
                    style: TextStyle(
                      fontFamily: 'san-serif',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: MyColors.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Selector<LoginProvider, bool>(
                    selector: (p0, p1) => p1.isLoading,
                    builder: (context, verify, child) {
                      return CustomWidgets.customButton(
                        context: context,
                        height: 60,
                        isLoading: verify,
                        buttonName: 'Submit',
                        onPressed: () {
                          final pin = pinController.text.trim();
                          final loginProvider = context.read<LoginProvider>();

                          loginProvider.verifyUserPin(pin, context);
                          // context.read<RouteProvider>().navigateTo(
                          //   '/home',
                          //   context,
                          // );
                        },
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        fontColor: Colors.white,
                        btnColor: MyColors.primaryColor,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
