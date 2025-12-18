import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:givt_driver_app/Utils/api_repository.dart';
import 'package:givt_driver_app/Views/home/AppSetting/profilemodal.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider();

  bool? isLoading = false;
  ProfileModal? profileModal;
  String? pageResult;

  // Providers

  Future<void> profileInformation() async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await ApiRepository.profileInfo();

      if (result != null && result.statusCode == 201) {
        final data = result.data;

        if (data != null && data['success'] == true) {
          final jsonRes =
              data['vouchers']; // change this if your key is different
          print(jsonRes);
          profileModal = ProfileModal.fromJson(jsonRes);
        } else {
          debugPrint("API returned success: false");
        }
      } else {
        debugPrint("Status code error: ${result?.statusCode}");
      }
    } catch (e) {
      debugPrint("profileInformation error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Edit profile

  Future<void> editProfile(ProfileModal req, context) async {
    print("testing request: ${req.dob}");
    isLoading = true;
    notifyListeners();
    try {
      final result = await ApiRepository.editProfile(profileModal: req);

      if (result != null && result.statusCode == 201) {
        final msg = result.data['message'];

        Navigator.pop(context);
        FlutterToastr.show(
          msg,
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
        );
      } else {
        debugPrint("Status code error: ${result?.statusCode}");
      }
    } catch (e) {
      debugPrint("profileInformation error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // change mobile number

  Future<void> changeMob(String mob, context) async {
    print("testing request: ${mob}");
    isLoading = true;
    notifyListeners();
    try {
      final result = await ApiRepository.changeMobile(mobile: mob);

      if (result != null && result.statusCode == 201) {
        final msg = result.data['message'];

        Navigator.pop(context);
        FlutterToastr.show(
          msg,
          context,
          duration: FlutterToastr.lengthLong,
          position: FlutterToastr.center,
        );
      } else {
        debugPrint("Status code error: ${result?.statusCode}");
      }
    } catch (e) {
      debugPrint("profileInformation error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // page content
  Future<void> pageContent(String page, context) async {
    print("testing request: ${page}");
    isLoading = true;
    notifyListeners();
    try {
      final result = await ApiRepository.contentPages(pageName: page);

      if (result != null && result.statusCode == 201) {
        pageResult = result.data['data'];
      } else {
        debugPrint("Status code error: ${result?.statusCode}");
      }
    } catch (e) {
      debugPrint("profileInformation error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
