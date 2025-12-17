import 'package:cached_network_image/cached_network_image.dart';
import 'package:givt_driver_app/MyPageRoute/route_provider.dart';

import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/Views/home/Coupon/categories_modal.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_modal_response.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_provider.dart';

import 'package:givt_driver_app/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CouponHomepage extends StatefulWidget {
  CouponHomepage({super.key});

  @override
  State<CouponHomepage> createState() => _CouponHomepageState();
}

class _CouponHomepageState extends State<CouponHomepage> {
  int selectedIndex = 0;
  CouponProvider couponProvider = CouponProvider();
  VouchersList vouchersList = VouchersList();

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
      height: itemHeight * 0.1,
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
                      "${vouchers!.brandLogoBaseUrl}/${vouchers.vouchers![index!].brand!.brandLogo.toString()}",
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
                      vouchers.vouchers![index].voucherTitle ?? "",
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
                      vouchers.vouchers![index].brand!.companyName ?? "",
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
              size: Size(80, 50), // width, height for the triangle area
              painter: RightTrianglePainter(),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 12,
            child: CustomPaint(
              size: Size(80, 50), // width, height for the triangle area
              child: Text(
                vouchers.vouchers![index].discountAmount.toString() +
                    vouchers.vouchers![index].discountType.toString(),
                style: TextStyle(
                  fontSize:
                      vouchers.vouchers![index].discountType.toString() == "SAR"
                      ? 12
                      : 16,
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

 
 
  Widget listOfContainers(List<String>? myImages) {
    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;
    if (myImages!.length > 4) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Celebration",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkEnabled ? Colors.white : MyColors.bodyTextColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<RouteProvider>().navigateTo(
                    '/viewall',
                    context,
                    arguments: 'Celebration',
                  );
                },
                child: Text(
                  "ViewAll ${myImages.length.toString()}",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDarkEnabled
                        ? Colors.white
                        : MyColors.bodyTextColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: voucherContainer(context),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Celebration",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkEnabled ? Colors.white : MyColors.bodyTextColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<RouteProvider>().navigateTo(
                    '/viewall',
                    context,
                    arguments: 'Celebration',
                  );
                },
                child: Text(
                  "ViewAll",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDarkEnabled
                        ? Colors.white
                        : MyColors.bodyTextColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: voucherContainer(context),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24);

    final isDarkEnabled = Theme.brightnessOf(context) == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: Consumer<CouponProvider>(
                  builder: (ctx, provider, child) {
                    return StreamBuilder<List<CategoriesList>>(
                      stream: provider.categoriesStream(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => categoryShimmer(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("No categories found."),
                          );
                        } else {
                          final categories =
                              snapshot.data!; // ✅ List<CategoriesList>

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  categories[index]; // ✅ Each category object
                              final isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  provider.setCategory(
                                    category.id.toString(),
                                  ); // ✅ pass correct id
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.grey
                                          : Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey.shade200,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: Center(
                                        child: Text(
                                          category.category ??
                                              '', // ✅ safe access
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              CustomWidgets.gap_10,
              Consumer<CouponProvider>(
                builder: (ctx, couponProv, child) {
                  CategoriesList categoriesList = CategoriesList();

                  return StreamBuilder(
                    stream: couponProv.getVouchers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return voucherShimmer();
                      } else if (!snapshot.hasData ||
                          snapshot.data!.vouchers == null ||
                          snapshot.data!.vouchers!.isEmpty) {
                        return Text("No Vouchers Found");
                      } else {
                        final vouchersList = snapshot.data!;
                        // final baseUrl=snapshot.data!.brandLogoBaseUrl;
                        return
                        //  Column(
                        //   children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   // mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Text(
                        //       vouchersList.vouchers![0].category!.category.toString(),
                        //       style: GoogleFonts.inter(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600,
                        //         color: isDarkEnabled
                        //             ? Colors.white
                        //             : MyColors.bodyTextColor,
                        //       ),
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         context.read<RouteProvider>().navigateTo(
                        //           '/viewall',
                        //           context,
                        //           arguments: 'Celebration',
                        //         );
                        //       },
                        //       child: Text(
                        //         "ViewAll",
                        //         style: GoogleFonts.inter(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w600,
                        //           color: isDarkEnabled
                        //               ? Colors.white
                        //               : MyColors.bodyTextColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Expanded(
                          child: GridView.builder(
                            scrollDirection:
                                Axis.vertical, // Allows horizontal scrolling
                            itemCount: vouchersList.vouchers!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 rows
                                  mainAxisSpacing: 10, // Space between columns
                                  crossAxisSpacing: 10, // Space between rows
                                  childAspectRatio: 0.8,
                                  mainAxisExtent: 120,
                                ),
                            itemBuilder: (context, index) {
                              return voucherContainer(
                                context,
                                vouchers: vouchersList,
                                index: index,
                              );
                            },
                          ),
                        );
                        //   ],
                        // );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  categoryShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors
                .white, // use non-selected border color or shimmer baseColor
            width: 2,
          ),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors
                .grey
                .shade200, // shimmer base or highlight color placeholder
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
              height: 20, // approximate height for text area
              width: 80, // approximate width for text area
              child: Container(
                color: Colors.white,
              ), // blank container for shimmer effect
            ),
          ),
        ),
      ),
    );
  }

  voucherShimmer() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 20,
                    width:
                        100, // Adjust width as needed for your title shimmers

                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 20,
                    width: 100, // Adjust for "ViewAll XX"

                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4, // Number of shimmer placeholders you want
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white,
                    period: Duration(seconds: 3),
                    direction: ShimmerDirection.ltr,

                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.1,

                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              },
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
