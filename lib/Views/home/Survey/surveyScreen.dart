import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_modal_response.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SurveryPage extends StatefulWidget {
  const SurveryPage({super.key});

  @override
  State<SurveryPage> createState() => _SurveryPageState();
}

class _SurveryPageState extends State<SurveryPage> {
  int? selectedIndex;
  bool submitting = false;
  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: 
      FutureBuilder<Map<String, dynamic>>(
        future: fetchSurveyFromApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          final questions = data['list'];
          final current = questions[questionIndex];
          final q = data['list'][0]["question"];
          final options = List<String>.from(q["options"]);

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Customer Research",
                            style: GoogleFonts.inter(
                              color: MyColors.bodyTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Help us to understand your preferences",
                            style: GoogleFonts.inter(
                              color: MyColors.bodyTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      FutureBuilder<Map<String, dynamic>>(
                        future: fetchSurveyFromApi(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return SizedBox();
                          return Row(
                            children: [
                              Icon(Icons.star, color: Colors.red, size: 18),
                              Text(
                                "${snapshot.data!['list'][0]['points']} pts",
                                style: GoogleFonts.inter(
                                  color: MyColors.bodyTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 16),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Progress bar and question count
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value:
                              (data['list'][0]["currentQuestionIndex"] + 1) /
                              data['list'][0]["totalQuestions"],
                          color: Colors.red,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Question ${data['list'][0]["currentQuestionIndex"] + 1} of ${data['list'][0]["totalQuestions"]}",
                        style: GoogleFonts.inter(
                          color: MyColors.bodyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Card with question
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Text(
                                "${data['list'][0]["currentQuestionIndex"] + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.cake, color: Colors.yellowAccent),
                            Text(
                              "+${q["points"]} points",
                              style: TextStyle(
                                color: Colors.yellowAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        Text(
                          q["text"],
                          style: GoogleFonts.inter(
                            color: MyColors.backgroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16),

                        // ...List.generate(options.length, (i) {
                        //   return Container(
                        //     margin: EdgeInsets.symmetric(vertical: 6),
                        //     child: Material(
                        //       color: selectedIndex == i
                        //           ? Colors.red[700]
                        //           : Colors.grey[850],
                        //       borderRadius: BorderRadius.circular(12),
                        //       child: InkWell(
                        //         borderRadius: BorderRadius.circular(12),
                        //         onTap: submitting
                        //             ? null
                        //             : () {
                        //                 setState(() => selectedIndex = i);
                        //                 print(
                        //                   "Selected option=> $selectedIndex",
                        //                 );
                        //               },
                        //         child: Padding(
                        //           padding: EdgeInsets.symmetric(
                        //             vertical: 14,
                        //             horizontal: 10,
                        //           ),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 options[i],
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 15,
                        //                 ),
                        //               ),
                        //               Icon(
                        //                 Icons.chevron_right,
                        //                 color: Colors.white54,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   );
                        // }),
                        FutureBuilder<Map<String, dynamic>>(
                          future: fetchSurveyFromApi(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final data = snapshot.data!;
                            final questions = data['list'];
                            final current = questions[questionIndex];
                            final q = current["question"];
                            final options = List<String>.from(q["options"]);

                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  // ... previous UI code (header/progress etc) ...
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: EdgeInsets.all(18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // ... points, question count etc ...
                                        SizedBox(height: 16),
                                        ...List.generate(options.length, (i) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 6,
                                            ),
                                            child: Material(
                                              color: selectedIndex == i
                                                  ? Colors.red[700]
                                                  : Colors.grey[850],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                onTap: submitting
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          selectedIndex = i;
                                                          print(
                                                            'Selected option=> $selectedIndex',
                                                          );
                                                          // Submit answer logic here, then go to next question
                                                          if (questionIndex <
                                                              questions.length -
                                                                  1) {
                                                            questionIndex++;
                                                            selectedIndex =
                                                                null; // reset UI for new question
                                                          } else {
                                                            // Survey finished: show a dialog or action
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) => AlertDialog(
                                                                title: Text(
                                                                  'Survey Complete',
                                                                ),
                                                                content: Text(
                                                                  'Thanks for your responses!',
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                          context,
                                                                        ),
                                                                    child: Text(
                                                                      'Close',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        });
                                                      },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 10,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        options[i],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.chevron_right,
                                                        color: Colors.white54,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  // ...rest of your code (footer, actions etc) ...
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Prev button & timer
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.arrow_back),
                        label: Text("Previous"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              data['list'][0]["currentQuestionIndex"] + 1 == "1"
                              ? Colors.grey[500]
                              : data['list'][0]["currentQuestionIndex"] + 1 ==
                                    "2"
                              ? Colors.red[500]
                              : Colors.grey[500],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Spacer(),
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.white54,
                        size: 16,
                      ),
                      Text(
                        " ~${data['list'][0]["remainingTimeMin"]} min remaining",
                        style: GoogleFonts.inter(
                          color: MyColors.bodyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Questions answered
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Questions Answered",
                        style: GoogleFonts.inter(
                          color: MyColors.bodyTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${data['list'][0]["questionsAnswered"]}/${data['list'][0]["totalQuestions"]}",
                        style: GoogleFonts.inter(
                          color: MyColors.bodyTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // CustomWidgets.customButton(
                  //   context: context,
                  //   height: 60,
                  //   buttonName: 'Submit',
                  //   fontColor: Colors.white,
                  //   fontSize: 16,

                  //   fontWeight: FontWeight.w600,
                  //   btnColor: Colors.red,
                  //   onPressed: (selectedIndex != null && !submitting)
                  //       ? () async {
                  //           // setState(() => submitting = true);
                  //           await submitAnswerToApi(
                  //             q["id"],
                  //             options[selectedIndex!],
                  //           );
                  //           // Optionally: show snackbar or advance to next question
                  //           setState(() => submitting = false);
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             SnackBar(content: Text("Answer submitted!")),
                  //           );
                  //         }
                  //       : null,
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    
    
    
    );
  }

  Future<Map<String, dynamic>> fetchSurveyFromApi() async {
    await Future.delayed(Duration(seconds: 1));
    return {
      "list": [
        {
          "points": 191,
          "currentQuestionIndex": 0,
          "totalQuestions": 5,
          "questionsAnswered": 1,
          "remainingTimeMin": 2,
          "question": {
            "id": 4,
            "points": 12,
            "text": "What type of vouchers interested you most?",
            "options": [
              "Fashion & Clothing",
              "Electronic & Tech",
              "Beauty & Dining",
              "Food & Drinking",
              "Travel & Hotels",
            ],
          },
        },
        {
          "points": 199,
          "currentQuestionIndex": 1,
          "totalQuestions": 5,
          "questionsAnswered": 2,
          "remainingTimeMin": 2,
          "question": {
            "id": 5,
            "points": 8,
            "text": "How often do you shop online",
            "options": ["Daily", "Weekly", "Monthly", "Rarely"],
          },
        },
        {
          "points": 207,
          "currentQuestionIndex": 2,
          "totalQuestions": 5,
          "questionsAnswered": 3,
          "remainingTimeMin": 2,
          "question": {
            "id": 6,
            "points": 8,
            "text": "Rate your interest in discount vouchers (1-5 stars)",
            "options": ["1", "2", "3", "4", "5"],
            "type": "rating",
          },
        },
        {
          "points": 236,
          "currentQuestionIndex": 3,
          "totalQuestions": 5,
          "questionsAnswered": 4,
          "remainingTimeMin": 2,
          "question": {
            "id": 7,
            "points": 12,
            "text": "Which brands do you prefer?",
            "options": [
              "Luxury brands",
              "Mid-range brands",
              "Budget-friendly brands",
              "Local brands",
              "International brands",
            ],
          },
        },
        // Add more questions as needed...
      ],
    };
  }

  Future<void> submitAnswerToApi(int questionId, String selectedOption) async {
    await Future.delayed(Duration(milliseconds: 500));
    // Replace with actual POST HTTP call.
    print('Submitted QID $questionId: $selectedOption');
  }
}
