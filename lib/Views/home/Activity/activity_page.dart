import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
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
            .loadScannedVouchers(); // Example function call from provider
      });
    });
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'sans-serif',
            fontSize: 9,
            color: MyColors.appSteelGrey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'sans-serif',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: MyColors.bodyTextColor,
          ),
        ),
      ],
    );
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
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: MyColors.secondaryColor.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Decorative Circle
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.appaqua.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.appaqua.withOpacity(0.08),
                ),
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Discount Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.appaqua,
                              MyColors.appaqua.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.appaqua.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${voucher!.discountAmount ?? 0}${voucher.discountType ?? '%'}",
                              style: const TextStyle(
                                fontFamily: 'sans-serif',
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "OFF",
                              style: TextStyle(
                                fontFamily: 'sans-serif',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Title and Code
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              voucher.voucherTitle ?? "-",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'sans-serif',
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isDarkEnabled
                                    ? Colors.black
                                    : MyColors.bodyTextColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Code with dashed border
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Text(
                                      voucher.voucherCode?.toString() ?? "-",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: 'sans-serif',
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.bodyTextColor,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Icon(
                                      Icons.copy_rounded,
                                      size: 16,
                                      color: MyColors.appaqua,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Logo
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: MyColors.appaqua.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/images/couponlogo.png',
                            height: 28,
                            width: 28,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Dashed Divider
                  Row(
                    children: List.generate(
                      40,
                      (index) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 1,
                          color: index.isEven
                              ? Colors.grey.shade300
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Valid From
                      _buildInfoBox(
                        icon: Icons.event_available_outlined,
                        label: "Valid From",
                        value: voucher.validFrom?.toString() ?? "-",
                        color: Colors.green,
                      ),
                      // Valid Upto
                      _buildInfoBox(
                        icon: Icons.event_busy_outlined,
                        label: "Valid Upto",
                        value: voucher.validUpto?.toString() ?? "-",
                        color: Colors.orange,
                      ),
                      // Min Purchase
                      _buildInfoBox(
                        icon: Icons.shopping_bag_outlined,
                        label: "Min Order",
                        value: "₹${voucher.minPurchase ?? '-'}",
                        color: Colors.blue,
                      ),
                      // Max Discount
                      _buildInfoBox(
                        icon: Icons.savings_outlined,
                        label: "Max Save",
                        value: "₹${voucher.maxDiscount ?? '-'}",
                        color: MyColors.appaqua,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.appaqua,
        onPressed: () {
          context.read<ActivityProvider>().loadScannedVouchers();
        },
        child: Icon(Icons.refresh, color: MyColors.backgroundColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Consumer<ActivityProvider>(
          builder: (context, provider, _) {
            if (provider.scannedFuture == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return FutureBuilder<List<ScannedVouModal>>(
              future: provider.scannedFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No vouchers found"));
                }

                final vouchers = snapshot.data!;

                return ListView.builder(
                  itemCount: vouchers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle voucher tap if needed
                        context.read<RouteProvider>().navigateTo(
                          '/detailedInfoScannedVoucher',
                          context,
                          arguments: vouchers[index],
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: voucherContainer(
                          context,
                          vouchers: vouchers[index],
                          index: index,
                        ),
                      ),
                    );
                  },
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
