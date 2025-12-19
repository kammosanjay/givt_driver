import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
import 'package:givt_driver_app/Views/home/AppSetting/profile_provider.dart';
import 'package:givt_driver_app/Views/language/language.dart';
import 'package:givt_driver_app/Views/Authentications/loginpage/login_provider.dart';
import 'package:givt_driver_app/Views/theme/theme_provider.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  void applang() {
    final isDarkEnabled = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDarkEnabled
              ? Colors.white
              : MyColors.secondaryColor,
          title: Text(
            "Language",
            style: TextStyle(
              fontFamily: 'san-serif',
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: MyColors.bodyText,
            ),
          ),
          content: DropdownButton<String>(
            value: context.watch<Language>().selectectLocale.languageCode,
            items: Language.languages
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e['locale'],
                    child: Text(
                      e['name'],
                      style: TextStyle(
                        fontFamily: 'san-serif',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: MyColors.bodyText,
                      ),
                    ),
                  ),
                )
                .toList(),
            dropdownColor: isDarkEnabled
                ? MyColors.backgroundColor
                : MyColors.backgroundColor,
            onChanged: (value) {
              if (value != null) {
                context.read<Language>().changeLanguage(value);
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    final appLoc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // --- Account
              SettingsTile(
                img: Image.asset(
                  'assets/images/person.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "Edit Profile",
                onTap: () {
                  context.read<RouteProvider>().navigateTo(
                    '/editProfile',
                    context,
                  );
                }, // Navigate to Edit Profile
              ),
              CustomWidgets.gap_10,
              SettingsTile(
                img: Image.asset(
                  'assets/images/change_pin.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "Change PIN",
                onTap: () {
                  context.read<RouteProvider>().navigateTo(
                    '/changePinScreen',
                    context,
                  );
                }, // Change password
              ),
              CustomWidgets.gap_10,
              SettingsTile(
                img: Image.asset(
                  'assets/images/changenum.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "Change Mobile Number",
                onTap: () {
                  context.read<RouteProvider>().navigateTo(
                    '/changeMobNum',
                    context,
                  );
                }, // Change password
              ),

              // --- Appearance
              // SettingsTile(
              //   icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
              //   title: "Theme",
              //   onTap: () {},
              //   trailing: Switch(
              //     value: isDarkMode,
              //     onChanged: (value) {
              //       // Call your theme provider or setState to switch theme
              //     },
              //   ),
              // ),
              CustomWidgets.gap_10,

              SettingsTile(
                img: Image.asset(
                  'assets/images/langone.png',
                  color: isDarkEnabled ? Colors.white : MyColors.primaryColor,
                  height: 22,
                  width: 22,
                ),
                onTap: applang,
                title: "App Language",
                trailing: Image.asset(
                  'assets/images/translation.png',
                  height: 20,
                  width: 20,
                  color: isDarkEnabled ? Colors.white : MyColors.bodyText,
                ),
              ),

              CustomWidgets.gap_10,

              // --- Privacy & Security
              SettingsTile(
                img: Image.asset(
                  'assets/images/faqimgs.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "FAQ's",
                onTap: () {
                  context.read<RouteProvider>().navigateTo('/FAQ', context);
                },
              ),
              CustomWidgets.gap_10,
              SettingsTile(
                img: Image.asset(
                  'assets/images/pp.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "Privacy Policy",
                onTap: () {
                  context.read<RouteProvider>().navigateTo(
                    '/privacyPolicy',
                    context,
                  );
                  context.read<ProfileProvider>().pageContent(
                    'privacy_policy',
                    context,
                  );
                },
              ),

              CustomWidgets.gap_10,

              // --- About & Logout
              SettingsTile(
                img: Image.asset(
                  'assets/images/aboutapp.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "About App",
                onTap: () {
                  context.read<RouteProvider>().navigateTo('/about', context);
                  context.read<ProfileProvider>().pageContent(
                    'about_app',
                    context,
                  );
                },
              ),
              CustomWidgets.gap_10,
              SettingsTile(
                img: Image.asset(
                  'assets/images/cusimg.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "Customer Support Information",
                onTap: () {
                  context.read<RouteProvider>().navigateTo(
                    '/customerSupp',
                    context,
                  );
                  context.read<ProfileProvider>().pageContent(
                    'customer_support',
                    context,
                  );
                },
              ),
              CustomWidgets.gap_10,
              SettingsTile(
                img: Image.asset(
                  'assets/images/logoutdone.png',
                  height: 22,
                  width: 22,
                  color: isDarkEnabled
                      ? MyColors.backgroundColor
                      : MyColors.primaryColor,
                ),
                title: "Logout",
                textColor: Colors.red,
                onTap: () {
                  logout(context);
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Night Mode',
                      style: TextStyle(
                        fontFamily: 'san-serif',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDarkEnabled
                            ? Colors.white
                            : MyColors.textColor,
                      ),
                    ),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return Switch(
                          value: themeProvider.themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            themeProvider.setThemeMode(
                              value ? ThemeMode.dark : ThemeMode.light,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent, // So the gradient is visible
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).brightness == Brightness.dark
              ? MyColors.primaryColor
              : MyColors.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: MyColors.backgroundColor,
              // color: Colors. grey,
              offset: Offset(-2, -2),
              blurRadius: 5,

              // inset: false,
            ),
            BoxShadow(
              color: MyColors.textColor,
              offset: Offset(2, 2),
              blurRadius: 5,

              // inset: true,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Confirm Logout",
                style: TextStyle(
                  fontFamily: 'san-serif',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : MyColors.textColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Are you sure you want to Logout?",
                style: TextStyle(
                  fontFamily: 'san-serif',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : MyColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: 'san-serif',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : MyColors.textColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await context.read<LoginProvider>().logout(context);
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'san-serif',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : MyColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class SettingsTile extends StatelessWidget {
  final Image img;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color? textColor;

  const SettingsTile({
    required this.img,
    required this.title,
    this.trailing,
    required this.onTap,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: img,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'san-serif',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.brightnessOf(context) == Brightness.dark
              ? Colors.white
              : MyColors.bodyTextColor,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      tileColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      minLeadingWidth: 24,
    );
  }
}
