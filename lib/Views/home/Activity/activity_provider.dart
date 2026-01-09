import 'package:flutter/widgets.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:givt_driver_app/MyPageRoute/route_provider.dart';
import 'package:givt_driver_app/Utils/api_repository.dart';
import 'package:givt_driver_app/Views/home/Activity/scannedVouModal.dart';
import 'package:givt_driver_app/Views/home/bottomnavProvider.dart';
import 'package:provider/provider.dart';

class ActivityProvider with ChangeNotifier {
  bool isLoading = false;
  ActivityProvider() {
    loadScannedVouchers();
  }

  ///
  // Future<List<ScannedVouModal>> getSannedVouchersList({String? date}) async {
  //   try {
  //     final response = await ApiRepository.getScannedVoucherList();

  //     if (response != null &&
  //         response.statusCode == 201 &&
  //         response.data['success'] == true) {
  //       final List list = response.data['vouchers'] ?? [];

  //       return list.map((e) => ScannedVouModal.fromJson(e)).toList();
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     debugPrint("Error fetching vouchers: $e");
  //     return [];
  //   }
  // }
  Future<List<ScannedVouModal>>? scannedFuture;

  Future<void> loadScannedVouchers() async {
    scannedFuture = ApiRepository.getScannedVoucherList().then((response) {
      if (response != null &&
          response.statusCode == 201 &&
          response.data['success'] == true) {
        final List list = response.data['vouchers'] ?? [];
        return list.map((e) => ScannedVouModal.fromJson(e)).toList();
      }
      return <ScannedVouModal>[];
    });

    notifyListeners(); // 🔥 THIS triggers UI refresh
  }

  ///
  Future<void> scannedVoucher(String? vouCode, BuildContext context) async {
    try {
      final response = await ApiRepository.scanVoucher(vCode: vouCode);

      final ok =
          response != null &&
          (response.statusCode == 200 || response.statusCode == 201) &&
          response.data['success'] == true;

      if (!ok) {
        debugPrint("Scan failed: ${response?.statusCode}  ${response?.data}");
        return;
      }

      if (context.mounted) {
        FlutterToastr.show(
          response.data['message'] ?? "Voucher scanned successfully",
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
        );
      }

      await loadScannedVouchers();

      if (!context.mounted) return;

      Navigator.of(context).pop(); // close scanner screen if it was pushed
      context.read<BottomNavProvider>().changeIndex(1);
    } catch (e) {
      debugPrint("Error fetching vouchers: $e");
    }
  }
}
