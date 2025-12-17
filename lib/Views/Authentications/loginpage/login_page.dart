import 'dart:math';

import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_provider.dart';

import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:givt_driver_app/Views/Authentications/signUpPage/signup_page.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
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
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      // backgroundColor: Colors.pinkAccent,
      resizeToAvoidBottomInset: true,
      body: ListView(
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

                  style: TextStyle(
                    fontFamily: 'san-serif',
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
            child: Consumer<LoginProvider>(
              builder: (context, loginProvider, _) {
                if (loginProvider.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login/SignUp',
                          style: TextStyle(
                            fontFamily: 'san-serif',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: MyColors.bodyTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login to continue your journey with Givt',
                          style: TextStyle(
                            fontFamily: 'san-serif',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: MyColors.hintColor,
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
                              name: "Mobile Number",
                              // label: 'Enter your mobile number',
                              hintfontSize: 14,

                              hintfontWeight: FontWeight.normal,
                              fontwgt: FontWeight.w600,
                              headingcolor: MyColors.hintColor,
                              hint: 'Enter your mobile number',

                              hintColor: MyColors.hintColor,
                              controller: mobileController,
                              keyboardtype: TextInputType.number,
                              icon: Image(
                                image: AssetImage('assets/images/mobile.png'),
                                height: 14,
                                width: 18,
                                color: MyColors.primaryColor,
                              ),
                            ),

                            SizedBox(height: 10),
                            Lottie.asset(
                              'assets/lottie/Delivery3.json',
                              height: 175,
                            ),

                            // Image.asset("assets/images/delivery.jpg",height: 200,),
                            SizedBox(height: 10),
                            CustomWidgets.customButton(
                              context: context,
                              height: 60,
                              buttonName: 'Login',
                              onPressed: () {
                                final loginProvider = context
                                    .read<LoginProvider>();

                                final mobile = mobileController.text.trim();

                                if (mobile.isEmpty) {
                                  FlutterToastr.show(
                                    "Please your mobile number",
                                    context,
                                    duration: FlutterToastr.lengthShort,
                                    position: FlutterToastr.center,
                                    backgroundColor: Colors.red,
                                    textStyle: TextStyle(
                                      fontFamily: 'san-serif',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.backgroundColor,
                                    ),
                                  );
                                  return;
                                } else if (mobile.length < 10 ||
                                    mobile.length > 10) {
                                  FlutterToastr.show(
                                    "Please enter 10-digits mobile number",
                                    context,
                                    duration: FlutterToastr.lengthLong,
                                    position: FlutterToastr.center,
                                    backgroundColor: Colors.red,
                                    textStyle: TextStyle(
                                      fontFamily: 'san-serif',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.backgroundColor,
                                    ),
                                  );
                                  return;
                                } else {
                                  loginProvider.firebasePhoneVerification(
                                    mobile,
                                    context,
                                  );
                                }
                                //  context.read<RouteProvider>().navigateTo(
                                //     '/home',
                                //     context,
                                //   );
                              },
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              fontColor: Colors.white,
                              btnColor: MyColors.primaryColor,
                            ),
                            SizedBox(height: 20),

                            // SizedBox(height: 30),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: InkWell(
                            //     onTap: () {
                            //       // context.read<RouteProvider>().navigateTo(
                            //       //   '/signup',
                            //       //   context,
                            //       // );
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => SignupPage(),
                            //         ),
                            //       );
                            //     },
                            //     child: RichText(
                            //       text: TextSpan(
                            //         text: "Don't have an Account? ",
                            //         style: GoogleFonts.inter(
                            //           // color: AppColor.textColor(context),
                            //           color: MyColors.textColor,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w500,
                            //         ),
                            //         children: <TextSpan>[
                            //           TextSpan(
                            //             text: 'Register',
                            //             style: GoogleFonts.inter(
                            //               color: MyColors.primaryColor,
                            //               fontWeight: FontWeight.w900,
                            //               fontSize: 16,
                            //             ),
                            //           ),
                            //           TextSpan(
                            //             text: ' 👋',
                            //             style: TextStyle(fontSize: 18),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),

          // Image.asset('assets/images/delivery.jpg',)
        ],
      ),
    );
  }
}
