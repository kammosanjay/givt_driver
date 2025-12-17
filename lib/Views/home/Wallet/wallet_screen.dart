import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/database/database_provider.dart';
import 'package:givt_driver_app/database/databasetwo.dart';

import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late Databasetwo db;
  List<Map<String, dynamic>> list = [];
  bool isDbReady = false;

  @override
  void initState() {
    super.initState();

    initDB();
  }

  Future<void> initDB() async {
    db = Databasetwo.instance;

    await db.getDB();
    await fetchList(); // VERY IMPORTANT
  }

  Future<void> fetchList() async {
    final data = await db.fetch();
    setState(() {
      list = data;
    });
  }

  String? selectedvalue;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    print(selectedvalue);
    return Scaffold(
      // backgroundColor: Color(0xFFe7f3ff),
      body: Center(
        child: Column(
          spacing: 5,
          children: [
            Text(appLoc.wallet_page),

            CustomWidgets.customTextFeild(context: context, name: 'Enter Name'),
            CustomWidgets.customTextFeild(context: context, name: 'Contact'),
            CustomWidgets.customTextFeild(context: context, name: 'Address'),
            CustomWidgets.customDropdownField(
              context: context,
              items: const ['Male', 'Female'],
              selectedItem: selectedvalue, // from provider
              hint: 'Gender',
              onChanged: (value) {
                selectedvalue = value;
              },
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.white,
                    onTap: () async {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            height: 200,
                            child: Column(
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: CustomWidgets.customButton(
                                        context: context,
                                        buttonName: 'cancel',
                                        height: 40,
                                        fontSize: 20,
                                        fontColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomWidgets.customButton(
                                        context: context,

                                        buttonName: 'submit',
                                        fontColor: Colors.white,
                                        fontSize: 20,
                                        height: 40,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(8),
                      color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            list[index]['NAME'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            list[index]['CONTACT'].toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
