import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_modal_response.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {

    
    Widget voucherContainer(
      BuildContext context, {
      VouchersList? vouchers,
      int? index,
    }) {
      final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
      double itemHeight =
          (MediaQuery.of(context).size.height - kToolbarHeight - 24);
      double itemWidth = MediaQuery.of(context).size.width;
      return Container(
        width: itemWidth * 0.457,
        height: itemHeight * 0.15,
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
                // Circular logo (network)
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_hybrid&w=740&q=80",
                    placeholder: (context, url) => Icon(Icons.image, size: 24),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 18),
                    imageBuilder: (context, imageProvider) => Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // Main voucher title (column)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "hey",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkEnabled
                              ? Colors.black
                              : MyColors.textColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "hello",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDarkEnabled
                              ? Colors.black
                              : MyColors.bodyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Coupon logo asset (circle or square, right side)
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
                size: Size(itemWidth*0.228, itemHeight*0.06), // width, height for the triangle area
                painter: RightTrianglePainter(),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 12,
              child: CustomPaint(
                size: Size(80, 50), // width, height for the triangle area
                child: Text(
                  "vouchers",
                  style: TextStyle(
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

      body: ListView(
        children: [
          ...List.generate(
            20,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: voucherContainer(context),
            ),
          ),
        ],
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
