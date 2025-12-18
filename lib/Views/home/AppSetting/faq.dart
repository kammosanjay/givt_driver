import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';

class FrequentlyAskQuestion extends StatefulWidget {
  const FrequentlyAskQuestion({super.key});

  @override
  State<FrequentlyAskQuestion> createState() => _FrequentlyAskQuestionState();
}

class _FrequentlyAskQuestionState extends State<FrequentlyAskQuestion> {
  bool isSelected = false; // you can remove or connect it based on your logic
  bool isDarkEnabled = false; // or get from theme/provider

  final List<Map<String, String>> faqList = [
    {
      "question": "How can I redeem a voucher?",
      "answer":
          "You can redeem your voucher from the Purchased section by clicking the Redeem button.",
    },
    {
      "question": "What if my voucher expires?",
      "answer":
          "Expired vouchers cannot be redeemed. Please redeem before the expiration date.",
    },
    {
      "question": "How do I update my profile?",
      "answer": "Go to Settings → Profile and update your information easily.",
    },
    {
      "question": "Can I transfer vouchers?",
      "answer": "No, vouchers are non-transferable.",
    },
    {
      "question": "How can I contact support?",
      "answer": "Use the Contact Us page to chat or email support.",
    },
    {
      "question": "Why is my voucher not loading?",
      "answer": "Try refreshing the page or checking your internet connection.",
    },
    {
      "question": "What payment methods are supported?",
      "answer":
          "We support credit cards, debit cards, UPI, and online wallets.",
    },
  ];

  List<bool> expanded = List.filled(7, false);

  TextStyle customStyle(Color color) {
    return TextStyle(
      fontFamily: 'san-serif',
      fontSize: 14,
      color: isDarkEnabled ? MyColors.bodyText : MyColors.bodyText,
      fontWeight: FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text('FAQ', style: customStyle(Colors.black))),
      body: ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Card(
              elevation: 2,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    expanded[index] = !expanded[index];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // QUESTION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              faqList[index]["question"]!,
                              style: customStyle(
                                isSelected
                                    ? (isDarkEnabled
                                          ? MyColors.backgroundColor
                                          : Colors.white)
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Icon(
                            expanded[index]
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 26,
                          ),
                        ],
                      ),

                      // ANSWER
                      AnimatedCrossFade(
                        firstChild: Container(),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            faqList[index]["answer"]!,
                            style: customStyle(
                              isSelected
                                  ? (isDarkEnabled
                                        ? MyColors.backgroundColor
                                        : Colors.white)
                                  : Colors.black54,
                            ),
                          ),
                        ),
                        crossFadeState: expanded[index]
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
