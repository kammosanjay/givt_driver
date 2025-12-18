import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/Views/home/AppSetting/profile_provider.dart';
import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeMobScreen extends StatefulWidget {
  const ChangeMobScreen({super.key});

  @override
  State<ChangeMobScreen> createState() => _ChangeMobScreenState();
}

class _ChangeMobScreenState extends State<ChangeMobScreen> {
  late AnimationController _controller;

  late Animation<Alignment> _animation;

  bool isShown = true;

  TextEditingController mobileController = TextEditingController();

  bool moveLeft = false;

  bool showText = false;

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

    final box = GetStorage();
    final mob = box.read('user_mobile');
    mobileController.text = mob;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      // backgroundColor: Colors.pinkAccent,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
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
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.25,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 15),
              // height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: isDarkEnabled
                    ? const Color.fromARGB(255, 46, 45, 45)
                    : MyColors.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: isDarkEnabled ? Colors.black12 : Colors.red.shade50,
                    // spreadRadius: 10,
                    blurRadius: 5,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                  BoxShadow(
                    color: isDarkEnabled ? Colors.black12 : Colors.red.shade50,
                    // spreadRadius: 10,
                    blurRadius: 5,
                    offset: Offset(-1, -1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Change Mobile Number',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: isDarkEnabled
                            ? Colors.white
                            : MyColors.bodyTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Change Mobile Number to continue your journey with Givt',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: isDarkEnabled
                            ? Colors.white
                            : MyColors.bodyTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomWidgets.customTextFeild(
                          context: context,
                          name: 'Mobile',
                          hintfontSize: 14,

                          hintfontWeight: FontWeight.normal,
                          fontwgt: FontWeight.w600,
                          headingcolor: isDarkEnabled
                              ? Colors.white
                              : MyColors.bodyTextColor,
                          hint: 'Mobile',

                          hintColor: isDarkEnabled
                              ? Colors.white
                              : MyColors.bodyTextColor,
                          controller: mobileController,
                          fillcolor: isDarkEnabled
                              ? Colors.black
                              : MyColors.backgroundColor,
                          keyboardtype: TextInputType.emailAddress,
                          icon: Image(
                            image: AssetImage('assets/images/mobile.png'),
                            height: 14,
                            width: 18,
                            color: MyColors.primaryColor,
                          ),
                        ),

                        SizedBox(height: 100),

                        CustomWidgets.customButton(
                          context: context,
                          height: 60,
                          buttonName: 'Save Changes',
                          onPressed: () {
                            // final mobile = mobileController.text.trim();

                            // if (mobile.isEmpty) {
                            //   FlutterToastr.show(
                            //     "Please your mobile number",
                            //     context,
                            //     duration: FlutterToastr.lengthShort,
                            //     position: FlutterToastr.bottom,
                            //     backgroundColor: Colors.red,
                            //     textStyle: GoogleFonts.inter(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w600,
                            //       color: MyColors.backgroundColor,
                            //     ),
                            //   );
                            //   return;
                            // } else if (mobile.length < 10 ||
                            //     mobile.length > 10) {
                            //   FlutterToastr.show(
                            //     "Please enter 10-digits mobile number",
                            //     context,
                            //     duration: FlutterToastr.lengthLong,
                            //     position: FlutterToastr.bottom,
                            //     backgroundColor: Colors.red,
                            //     textStyle: GoogleFonts.inter(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w600,
                            //       color: MyColors.backgroundColor,
                            //     ),
                            //   );
                            //   return;
                            // } else {
                            //   profilePro.firebasePhoneVerification(
                            //     mobile,
                            //     context,
                            //   );
                            // }
                          },
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          fontColor: Colors.white,
                          btnColor: MyColors.primaryColor,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
