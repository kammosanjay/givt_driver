import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Views/home/Activity/activity_provider.dart';
import 'package:givt_driver_app/Views/home/Activity/scannedVouModal.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_modal_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call your function here
      Future.microtask(() {
        // Your function to be called after the first frame
        context
            .read<ActivityProvider>()
            .getSannedVouchersList(); // Example function call from provider
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget voucherContainer(
      BuildContext context, {
      ScannedVouModal? vouchers,
      int? index,
    }) {
      final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
      double itemHeight =
          (MediaQuery.of(context).size.height - kToolbarHeight - 24);
      double itemWidth = MediaQuery.of(context).size.width;

      final voucher = vouchers!.voucher;
      return Container(
        width: itemWidth * 0.457,
        height: itemHeight * 0.16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          voucher?.voucherTitle ?? "-",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'sans-serif',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: isDarkEnabled
                                ? Colors.black
                                : MyColors.bodyTextColor,
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Vocher Code : ",
                                style: TextStyle(
                                  fontFamily: 'sans-serif',
                                  color: MyColors.bodyText,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: voucher!.voucherCode?.toString() ?? "-",
                                style: const TextStyle(
                                  fontFamily: 'sans-serif',
                                  fontSize: 9,
                                  color: MyColors.bodyTextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Valid from : ",
                                    style: TextStyle(
                                      color: MyColors.bodyText,
                                      fontSize: 10,
                                      fontFamily: 'sans-serif',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: voucher.validFrom?.toString() ?? "-",
                                    style: const TextStyle(
                                      color: MyColors.bodyTextColor,
                                      fontSize: 9,
                                      fontFamily: 'sans-serif',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Valid Uptp : ",
                                    style: TextStyle(
                                      color: MyColors.bodyText,
                                      fontSize: 10,
                                      fontFamily: 'sans-serif',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: voucher.validUpto?.toString() ?? "-",
                                    style: const TextStyle(
                                      color: MyColors.bodyTextColor,
                                      fontSize: 9,
                                      fontFamily: 'sans-serif',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Min Pur : ",
                                style: TextStyle(
                                  color: MyColors.bodyText,
                                  fontSize: 10,
                                  fontFamily: 'sans-serif',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: voucher.minPurchase?.toString() ?? "-",
                                style: const TextStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: 9,
                                  fontFamily: 'sans-serif',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Max Discount : ",
                                style: TextStyle(
                                  color: MyColors.bodyText,
                                  fontSize: 10,
                                  fontFamily: 'sans-serif',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: voucher.maxDiscount?.toString() ?? "-",
                                style: const TextStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: 9,
                                  fontFamily: 'sans-serif',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 6.0),
                  child: Image.asset(
                    'assets/images/couponlogo.png',
                    height: 36,
                    width: 36,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            // Bottom-left T&C icon
            Positioned(
              left: 0,
              bottom: 0,
              child: Icon(
                Icons.article,
                size: 28,
                color: Colors.black,
              ), // placeholder for T&C
            ),

            // Bottom-right: 50% OFF
            Positioned(
              right: 5,
              bottom: 5,
              child: CustomPaint(
                size: Size(
                  itemWidth * 0.228,
                  itemHeight * 0.06,
                ), // width, height for the triangle area
                painter: RightTrianglePainter(),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 12,
              child: CustomPaint(
                size: Size(80, 50), // width, height for the triangle area
                child: Text(
                  "${voucher!.discountAmount.toString() + voucher.discountType.toString()}",
                  style: TextStyle(
                    fontFamily: 'sans-serif',
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 3,
              child: CustomPaint(
                size: Size(80, 50), // width, height for the triangle area
                child: Text(
                  "OFF",
                  style: TextStyle(
                    fontFamily: 'sans-serif',
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        child: FutureBuilder<List<ScannedVouModal>>(
          future: context.read<ActivityProvider>().getSannedVouchersList(),
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Empty / error
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No vouchers found"));
            }

            final vouchers = snapshot.data!;

            return ListView.builder(
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                final scanned = vouchers[index];
                final voucher = scanned.voucher;

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: voucherContainer(
                    context,
                    vouchers: vouchers[index],
                    index: index,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class RightTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height) // bottom-left
      ..lineTo(size.width, size.height) // bottom-right
      ..lineTo(size.width, 0) // top-right
      ..close(); // connect back to start

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
