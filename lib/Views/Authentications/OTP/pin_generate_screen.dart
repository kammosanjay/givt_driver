import 'package:flutter_toastr/flutter_toastr.dart';
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

class GeneratePinPage extends StatefulWidget {
  String? veriId;
  GeneratePinPage({super.key, this.veriId});

  @override
  State<GeneratePinPage> createState() => _GeneratePinPageState();
}

class _GeneratePinPageState extends State<GeneratePinPage>
    with SingleTickerProviderStateMixin {
  bool isShown = true;
  late AnimationController _controller;
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
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    // final from = ModalRoute.of(context)!.settings.arguments as String;
    // print("testing==>${from}");
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
                      color: isDarkEnabled ? Colors.white : MyColors.primaryColor,
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
              // height: MediaQuery.of(context).size.height * 0.7,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Creating a 6-digit PIN',
                    style: GoogleFonts.inter(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: MyColors.bodyTextColor,
                    ),
                  ),
                  Text(
                    'Access the App faster with a PIN',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: MyColors.hintColor,
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
                  SizedBox(height: 20),
                  Text(
                    "Authenticate with Biometric",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: MyColors.hintColor,
                    ),
                  ),
                  SizedBox(height: 20),
            
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
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: MyColors.hintColor,
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
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: MyColors.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            
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
            
                    buttonName: 'Submit',
                    onPressed: () {
                      final pin = pinController.text.trim();
                      final loginProvider = context.read<LoginProvider>();
            
                      // loginProvider.savePin(pin, context);
                      context.read<RouteProvider>().navigateReplace(
                        '/home',
                        context,
                      );
                    },
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    fontColor: Colors.white,
                    btnColor: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
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
      ),
    );
  }
}
