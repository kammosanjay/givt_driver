import 'package:flutter/material.dart';
import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/Views/home/Activity/activity_provider.dart';
import 'package:http/http.dart' show read;

import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class MobileScannerScreen extends StatefulWidget {
  @override
  State<MobileScannerScreen> createState() => _MobileScannerScreenState();
}

class _MobileScannerScreenState extends State<MobileScannerScreen> {
  Barcode? _barcode;
  bool isStart = false;
  MobileScannerController controller = MobileScannerController(
    cameraResolution: Size(100, 100),
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 250,
    formats: [],
    returnImage: true,
    torchEnabled: true,
    invertImage: true,
    autoZoom: true,
    autoStart: false,
  );

  Widget _barcodePreview(Barcode? value) {
    if (value == null) {
      return isStart == true
          ? Text(
              'Scan something!',
              overflow: TextOverflow.fade,
              style: TextStyle(color: Colors.white),
            )
          : Opacity(
              opacity: 0.4,
              child: Lottie.asset(
                'assets/lottie/qrcode.json',
                height: 150,
                width: 150,
              ),
            );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  bool _apiCalled = false; // prevent multiple hits

  void _handleBarcode(BarcodeCapture result, BuildContext context) {
    final barcode = result.barcodes.firstOrNull;

    if (barcode == null) return;

    if (!_apiCalled && mounted) {
      _apiCalled = true;

      setState(() {
        _barcode = barcode;
      });

      controller.stop(); // stop scanner after success

      context.read<ActivityProvider>().scannedVoucher(
        barcode.displayValue,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) => _handleBarcode(capture, context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(child: _barcodePreview(_barcode)),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: CustomWidgets.customButton(
                            buttonName: 'Start scanner',
                            height: 50,
                            context: context,
                            onPressed: () async {
                              await controller
                                  .start(); // Starts the camera and barcode scanning
                              setState(() {
                                isStart = true;
                              });
                            },
                            btnColor: MyColors.primaryColor,
                            fontColor: MyColors.backgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: CustomWidgets.customButton(
                            buttonName: 'Stop scanner',
                            height: 50,
                            context: context,
                            onPressed: () async {
                              await controller
                                  .stop(); // Stops the camera and barcode scanning
                              setState(() {
                                isStart = false;
                              });
                            },
                            btnColor: MyColors.primaryColor,
                            fontColor: MyColors.backgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
