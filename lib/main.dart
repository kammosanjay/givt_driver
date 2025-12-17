import 'package:firebase_core/firebase_core.dart';
import 'package:givt_driver_app/Views/Authentications/ForgotPIN/forgot_pin_screen.dart';
import 'package:givt_driver_app/Views/Authentications/OTP/firebase_otp_screen.dart';
import 'package:givt_driver_app/Views/Authentications/OTP/pin_generate_screen.dart';
import 'package:givt_driver_app/Views/ChangePinScreen/change_pin_screen.dart';
import 'package:givt_driver_app/Views/home/AppSetting/aboutScreen.dart';
import 'package:givt_driver_app/Views/home/AppSetting/app_setting_provider.dart';
import 'package:givt_driver_app/Views/home/AppSetting/app_setting_screen.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_provider.dart';
import 'package:givt_driver_app/Views/home/Coupon/qr_code.dart';
import 'package:givt_driver_app/Views/home/Survey/activity_page.dart';
import 'package:givt_driver_app/Views/home/Wallet/wallet_screen.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_homepage.dart';

import 'package:givt_driver_app/Views/home/Survey/surveyScreen.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/pinScreen.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_detaill_screen.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
import 'package:givt_driver_app/Views/home/dashboard.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_page.dart';
import 'package:givt_driver_app/Views/Authentications/signUpPage/signup_page.dart';
import 'package:givt_driver_app/Views/splash/splash_provider.dart';
import 'package:givt_driver_app/Views/splash/splash_screen.dart';
import 'package:givt_driver_app/database/databasetwo.dart';
import 'package:givt_driver_app/firebase_message.dart';
import 'package:givt_driver_app/firebase_options.dart';
import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:givt_driver_app/Views/language/language.dart';
import 'package:givt_driver_app/Views/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  await FirebaseMsg().initFCM();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Language>(create: (_) => Language()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),

        ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),

        ChangeNotifierProvider<RouteProvider>(create: (_) => RouteProvider()),
        ChangeNotifierProvider<CouponProvider>(create: (_) => CouponProvider()),

        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final langProvider = Provider.of<Language>(context, listen: true);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('ar'), Locale('en')],

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: langProvider.selectectLocale,
      // home:SignupPage() ,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MyHome(),
        '/pinPage': (context) => GeneratePinPage(),
        '/firebaseOtpScreen': (context) => OtpScreenByfirease(),
        '/loginbyPin': (context) => PinscreenLoginPage(),
        '/loginpage': (context) => LoginPage(),
        '/profilepage': (context) => AppSettingsPage(),
        '/qrpage': (context) => MobileScannerScreen(),
        '/signUpPage': (context) => SignupPage(),
        'profile': (context) => AppSettingsPage(),
        '/activityPage': (context) => ActivityPage(),
        'couponhomepage': (context) => CouponHomepage(),
        'forgotPIN': (context) => ForgotPinScreen(),
        '/changePinScreen': (context) => ChangePinScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
