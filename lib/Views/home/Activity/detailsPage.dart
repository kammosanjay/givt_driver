import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoucherDetailScreen extends StatelessWidget {
  final voucher; // Your voucher object

  const VoucherDetailScreen({Key? key, required this.voucher}) : super(key: key);

  // 🎨 Color Palette based on your color
  static const Color primaryLight = Color.fromRGBO(241, 218, 221, 1);  // Your color
  static const Color primaryMedium = Color.fromRGBO(219, 168, 175, 1); // Medium rose
  static const Color primaryDark = Color.fromRGBO(183, 110, 121, 1);   // Dark rose
  static const Color primaryDeep = Color.fromRGBO(139, 69, 79, 1);     // Deep rose
  static const Color primaryAccent = Color.fromRGBO(89, 45, 51, 1);    // Accent dark

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 247, 248, 1), // Very light pink bg
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryDeep),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Voucher Details",
          style: TextStyle(
            fontFamily: 'sans-serif',
            color: primaryDeep,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🎨 Gradient Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryMedium,
                    primaryDark,
                    primaryDeep,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryDark.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// 🏷️ Voucher Code Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.confirmation_number, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          voucher.voucherCode.toString(),
                          style: const TextStyle(
                            fontFamily: 'sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: voucher.voucherCode.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Code copied!"),
                                backgroundColor: primaryDeep,
                              ),
                            );
                          },
                          child: Icon(Icons.copy, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🔥 Voucher Title
                  Text(
                    voucher.voucherTitle.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'sans-serif',
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 💸 Discount Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_offer, color: primaryDeep, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          "${voucher.discountAmount}${voucher.discountType} OFF",
                          style: TextStyle(
                            fontFamily: 'sans-serif',
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: primaryDeep,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 📅 Validity Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryLight,
                          primaryLight.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: primaryMedium.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: primaryDeep,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Valid Period",
                                style: TextStyle(
                                  fontFamily: 'sans-serif',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryDeep,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${voucher.validFrom} - ${voucher.validUpto}",
                                style: TextStyle(
                                  fontFamily: 'sans-serif',
                                  fontSize: 13,
                                  color: primaryAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontFamily: 'sans-serif',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🛒 Purchase Conditions
                  Row(
                    children: [
                      Expanded(
                        child: _buildConditionCard(
                          icon: Icons.shopping_bag,
                          title: "Min Purchase",
                          value: "₹${voucher.minPurchase}",
                          isPrimary: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildConditionCard(
                          icon: Icons.discount,
                          title: "Max Discount",
                          value: "₹${voucher.maxDiscount}",
                          isPrimary: false,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 📝 Description
                  _buildInfoSection(
                    icon: Icons.description,
                    title: "Description",
                    content: voucher.description.toString(),
                  ),

                  const SizedBox(height: 16),

                  /// 📜 Terms & Conditions
                  _buildInfoSection(
                    icon: Icons.gavel,
                    title: "Terms & Conditions",
                    content: voucher.termsConditions.toString(),
                    isTerms: true,
                  ),

                  const SizedBox(height: 24),

                  /// ✅ Redeem Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryMedium, primaryDark, primaryDeep],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: primaryDark.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Your redeem logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "REDEEM NOW",
                            style: TextStyle(
                              fontFamily: 'sans-serif',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Share Button
                  OutlinedButton(
                    onPressed: () {
                      // Share logic
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryDark, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, color: primaryDark),
                        const SizedBox(width: 8),
                        Text(
                          "Share with Friends",
                          style: TextStyle(
                            fontFamily: 'sans-serif',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🎯 Condition Card Widget
  Widget _buildConditionCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isPrimary,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPrimary ? primaryLight : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary ? primaryMedium : primaryLight,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryMedium.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isPrimary ? primaryDeep : primaryMedium,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'sans-serif',
              fontSize: 12,
              color: primaryAccent.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'sans-serif',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryDeep,
            ),
          ),
        ],
      ),
    );
  }

  /// 📄 Info Section Widget
  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
    bool isTerms = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryMedium.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isTerms ? primaryLight : primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isTerms ? primaryDeep : primaryDark,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'sans-serif',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryDeep,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromRGBO(253, 247, 248, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontFamily: 'sans-serif',
                fontSize: 14,
                color: primaryAccent,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }




}