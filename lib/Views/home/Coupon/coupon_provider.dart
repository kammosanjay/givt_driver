import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:givt_driver_app/Utils/api_repository.dart';
import 'package:givt_driver_app/Views/home/Coupon/categories_modal.dart';
import 'package:givt_driver_app/Views/home/Coupon/coupon_modal_response.dart';

class CouponProvider with ChangeNotifier {
  var categoriesList = [];
  String? selectedCategoryId = 'all';

  //
  void setCategory(String id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  /// get All Categories
  ///

  Stream<List<CategoriesList>> categoriesStream() async* {
    while (true) {
      try {
        final response = await ApiRepository.getAllCategories();

        if (response?.statusCode == 201 && response?.data['success'] == true) {
          // Extract raw list
          final List<dynamic> categoriesJson =
              response!.data['categories'] ?? [];

          // Convert JSON → model
          List<CategoriesList> categoriesList = categoriesJson
              .map((list) => CategoriesList.fromJson(list))
              .toList();

          // Add your custom "All" option
          categoriesList.insert(0, CategoriesList(id: 0, category: 'All'));

          debugPrint(
            "✅ Categories: ${categoriesList.map((e) => e.category).toList()}",
          );

          yield categoriesList; // ✅ send model list to stream
        } else {
          yield <CategoriesList>[]; // empty list on failure
        }
      } catch (e) {
        debugPrint("❌ Error fetching categories: $e");
        yield <CategoriesList>[]; // yield empty list on error
      }

      // Optional refresh interval
      await Future.delayed(const Duration(hours: 1));
    }
  }

  /// get All Vouchers

  Stream<VouchersList> getVouchers({String? catId}) async* {
    while (true) {
      try {
        final response = await ApiRepository.getAllVouchers(
          categoryId: selectedCategoryId == 'all' ? "0" : selectedCategoryId,
        );

        if (response != null &&
            response.statusCode == 201 &&
            response.data['success'] == true) {
          final vouchersJson = response.data?? [];
          print("voucherslist==> $vouchersJson");

          // Extract the list
          final vouchersList = VouchersList.fromJson(vouchersJson);

          // Parse each item into model

          yield vouchersList;
        } else {
          yield  VouchersList(); // Yield old data if API fails
        }
      } catch (e) {
        debugPrint("Error fetching vouchers: $e");
        yield  VouchersList(); // Yield last known data
      }

      // Wait before fetching again
      await Future.delayed(const Duration(hours: 1));
    }
  }
}
