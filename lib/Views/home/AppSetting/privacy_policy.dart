import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Views/home/AppSetting/profile_provider.dart';
import 'package:provider/provider.dart';

class Privaycypolicy extends StatefulWidget {
  const Privaycypolicy({super.key});

  @override
  State<Privaycypolicy> createState() => _PrivaycypolicyState();
}

class _PrivaycypolicyState extends State<Privaycypolicy> {
  @override
  Widget build(BuildContext context) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontFamily: 'san-serif',
            color: isDarkEnabled ? Colors.white : MyColors.bodyText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, pageContent, child) {
          if (pageContent.isLoading!) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pageContent.pageResult.toString(),
                style: TextStyle(
                  fontFamily: 'san-serif',
                  color: isDarkEnabled ? Colors.white : MyColors.bodyText,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
