// import 'package:flutter/material.dart';

import 'package:givt_driver_app/Views/home/AppSetting/app_setting_screen.dart';

import 'package:givt_driver_app/Views/home/Coupon/coupon_homepage.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_driver_app/Views/home/Coupon/qr_code.dart';

import 'package:givt_driver_app/Views/home/Survey/activity_page.dart';
import 'package:givt_driver_app/Views/home/Wallet/wallet_screen.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:givt_driver_app/Views/theme/theme_provider.dart';

import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var locationController = TextEditingController();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    // CouponHomepage(),
    MobileScannerScreen(),
    ActivityPage(),
    WalletScreen(),
    AppSettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // update selected index
    });
  }

  // String? imagePath;

  Future<void> aboutUs() async {
    if (!await launchUrl(
      Uri.parse("https://buat.edu.in/about-university/"),
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch URL');
    }
  }

  Future<void> privacyPolicy() async {
    if (!await launchUrl(
      Uri.parse("https://buat.edu.in/#"),
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch URL');
    }
  }

  Future<void> termsAndcdtn() async {
    if (!await launchUrl(
      Uri.parse("https://buat.edu.in/#"),
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch URL');
    }
  }

  Future<void> contactUs() async {
    if (!await launchUrl(
      Uri.parse("https://buat.edu.in/contact-us/"),
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch URL');
    }
  }

  Widget drawerLitTile({
    required String title,
    required String icon,
    VoidCallback? ontap,
  }) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    return Container(
      color: isDarkEnabled ? Colors.white : MyColors.secondaryColor,
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyColors.bodyTextColor,
          ),
        ),
        trailing: SvgPicture.asset(icon, color: MyColors.textColor),
        tileColor: AppColor.backgroundColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onTap: ontap, // ✅ use the callback correctly
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;

    print("build");
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: _selectedIndex.isFinite
              ? MyColors.primaryColor
              : Colors.black, // This shows all 5 items
          unselectedItemColor: Color(0xFF333333),
          selectedFontSize: 12,
          unselectedFontSize: 10,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              tooltip: "Home",

              icon: Image.asset(
                'assets/images/homeIcon.png',
                height: 20,
                width: 20,
                color: _selectedIndex == 0
                    ? MyColors.primaryColor
                    : Colors.black45,
              ),

              label: appLoc.home,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/surveyIcon.png',
                height: 20,
                width: 20,
                color: _selectedIndex == 1
                    ? MyColors.primaryColor
                    : Colors.black45,
              ),
              label: appLoc.activity,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/walletIcon.png',
                height: 20,
                width: 20,
                color: _selectedIndex == 2
                    ? MyColors.primaryColor
                    : Colors.black45,
              ),
              label: appLoc.history,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/settingIcon.png',
                height: 20,
                width: 20,
                color: _selectedIndex == 3
                    ? MyColors.primaryColor
                    : Colors.black45,
              ),
              label: appLoc.settings,
            ),
          ],
        ),

        appBar: AppBar(
          // backgroundColor:Colors.grey.shade100,
          title: Text(
            "Welcome to Givt",
            style: TextStyle(
              fontFamily: 'san-serif',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDarkEnabled
                  ? MyColors.backgroundColor
                  : MyColors.bodyTextColor,
            ),
          ),

          leading: Image.asset("assets/images/couponlogo.png"),

          centerTitle: true,
        ),

        body: _pages[_selectedIndex],
      ),
    );
  }
}
