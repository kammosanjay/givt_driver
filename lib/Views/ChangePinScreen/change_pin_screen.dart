import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final oldPinController = TextEditingController();
  final newPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Change Pin")),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.6,
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
                'Enter Old PIN',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: MyColors.bodyTextColor,
                ),
              ),

              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PinCodeTextField(
                  appContext: context,
                  controller: oldPinController,
                  length: 6, // 6 digit OTP
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  cursorColor: Colors.black,
                  blinkWhenObscuring: true,

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
              Text(
                'Enter New PIN',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: MyColors.bodyTextColor,
                ),
              ),

              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PinCodeTextField(
                  appContext: context,
                  controller: newPinController,
                  length: 6, // 6 digit OTP
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  cursorColor: Colors.black,
                  blinkWhenObscuring: true,

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
              Spacer(),
              Text(
                'Your privacy matters—enter the code for secure access',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: MyColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 20),
              CustomWidgets.customButton(
                context: context,
                height: 60,
                buttonName: 'Submit',
                onPressed: () async {
                  final oldPIn = oldPinController.text.trim();
                  final newPin = newPinController.text.trim();
                  final loginProvider = context.read<LoginProvider>();

                  final otpResult = await loginProvider.changePinbyUser(
                    context,
                    newpin: newPin,
                    oldpin: oldPIn,
                  );
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
                      color: MyColors.bodyTextColor,
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
      ),
    );
  }
}
