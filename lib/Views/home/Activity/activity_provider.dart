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
      if (vouCode == null || vouCode.trim().isEmpty) {
        if (!context.mounted) return;
        FlutterToastr.show(
          "Invalid QR code",
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
        );
        return;
      }

      final response = await ApiRepository.scanVoucher(vCode: vouCode.trim());

      final status = response?.statusCode;
      final data = response?.data;

      // ----- ALREADY SCANNED handling (adjust to your backend) -----
      final serverMsg = (data is Map)
          ? (data['message']?.toString() ?? "")
          : "";
      final looksAlreadyScanned =
          status == 409 ||
          serverMsg.toLowerCase().contains("already") ||
          serverMsg.toLowerCase().contains("scanned");

      if (looksAlreadyScanned) {
        if (!context.mounted) return;
        
        FlutterToastr.show(
          serverMsg.isNotEmpty ? serverMsg : "This voucher is already scanned.",
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
        );
        return; // keep scanner open OR close it—your choice
      }

      // ----- SUCCESS handling -----
      final ok =
          response != null &&
          (status == 200 || status == 201) &&
          (data is Map && data['success'] == true);

      if (!ok) {
        debugPrint("Scan failed: $status  $data");
        if (!context.mounted) return;

        FlutterToastr.show(
          serverMsg.isNotEmpty ? serverMsg : "Scan failed. Please try again.",
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
        );
        return;
      }

      if (context.mounted) {
        FlutterToastr.show(
          serverMsg.isNotEmpty ? serverMsg : "Voucher scanned successfully",
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
        );
      }

      await loadScannedVouchers();

      if (!context.mounted) return;
      // Navigator.of(context).pop(); // close scanner screen
      context.read<BottomNavProvider>().changeIndex(1);
    } catch (e) {
      debugPrint("Error scanning voucher: $e");
      if (!context.mounted) return;

      FlutterToastr.show(
        "Something went wrong. Please try again.",
        context,
        duration: FlutterToastr.lengthLong,
        position: FlutterToastr.center,
      );
    }
  }
}
