import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Views/home/Activity/scannedVouModal.dart';

class DetailedInfoScannedVoucher extends StatefulWidget {
  const DetailedInfoScannedVoucher({super.key});

  @override
  State<DetailedInfoScannedVoucher> createState() =>
      _DetailedInfoScannedVoucherState();
}

class _DetailedInfoScannedVoucherState
    extends State<DetailedInfoScannedVoucher> {
  @override
  Widget build(BuildContext context) {
    final vouchersInfo =
        ModalRoute.of(context)!.settings.arguments as ScannedVouModal;
    final voucher = vouchersInfo.voucher!;
    // Cast to the appropriate type if needed
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Voucher Details",
          style: TextStyle(
            fontFamily: 'sans-serif',
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: MyColors.bodyTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 Voucher Title
            Text(
              voucher.voucherTitle.toString(),
              style: TextStyle(
                fontFamily: 'sans-serif',
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: MyColors.appSteelGrey,
              ),
            ),

            const SizedBox(height: 8),

            /// 🏷️ Voucher Code
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Text(
                "Code: ${voucher.voucherCode}",
                style: const TextStyle(
                  fontFamily: 'sans-serif',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 💸 Discount
            Row(
              children: [
                Icon(Icons.local_offer, color: Colors.red.shade400),
                const SizedBox(width: 6),
                Text(
                  "Get ${voucher.discountAmount}${voucher.discountType} OFF",
                  style: const TextStyle(
                    fontFamily: 'sans-serif',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 📅 Validity
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Validity",
                      style: TextStyle(
                        fontFamily: 'sans-serif',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "From: ${voucher.validFrom}",
                      style: TextStyle(fontFamily: 'sans-serif'),
                    ),
                    Text(
                      "Upto: ${voucher.validUpto}",
                      style: TextStyle(fontFamily: 'sans-serif'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 🛒 Purchase Conditions
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Purchase Conditions",
                      style: TextStyle(
                        fontFamily: 'sans-serif',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Minimum Purchase: ₹${voucher.minPurchase}",
                      style: TextStyle(fontFamily: 'sans-serif'),
                    ),
                    Text(
                      "Maximum Discount: ₹${voucher.maxDiscount}",
                      style: TextStyle(fontFamily: 'sans-serif'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 📝 Description
            const Text(
              "Description",
              style: TextStyle(
                fontFamily: 'sans-serif',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              voucher.description.toString(),
              style: const TextStyle(fontSize: 14, fontFamily: 'sans-serif'),
            ),

            const SizedBox(height: 16),

            /// 📜 Terms & Conditions
            const Text(
              "Terms & Conditions",
              style: TextStyle(
                fontFamily: 'sans-serif',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              voucher.termsConditions.toString(),
              style: const TextStyle(fontSize: 14, fontFamily: 'sans-serif'),
            ),

            /// ✅ Redeem Button
          ],
        ),
      ),
    );
  }
}
