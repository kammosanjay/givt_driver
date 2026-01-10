
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import 'package:givt_driver_app/Utils/appColor.dart';
import 'package:givt_driver_app/Utils/constant_widget.dart';
import 'package:givt_driver_app/Views/home/Activity/activity_provider.dart';

class MobileScannerScreen extends StatefulWidget {
  @override
  State<MobileScannerScreen> createState() => _MobileScannerScreenState();
}

class _MobileScannerScreenState extends State<MobileScannerScreen> {
  Barcode? _barcode;
  bool isStart = false;
  bool _apiCalled = false;

  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 250,
    returnImage: true,
    torchEnabled: false,
    autoZoom: true,
    autoStart: false,
  );

  void _handleBarcode(BarcodeCapture result, BuildContext context) {
    final barcode = result.barcodes.firstOrNull;
    if (barcode == null) return;

    if (!_apiCalled && mounted) {
      _apiCalled = true;

      setState(() => _barcode = barcode);
      controller.stop();

      context.read<ActivityProvider>().scannedVoucher(
        barcode.displayValue,
        context,
      );
    }
  }

  void _resetScan() {
    setState(() {
      _barcode = null;
      _apiCalled = false;
      // keep isStart as-is
    });
  }

  Widget _statusWidget() {
    if (!isStart) {
      return Row(
        children: [
          const Icon(Icons.qr_code_scanner, color: Colors.white70),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Tap Start and align the QR code inside the frame",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      );
    }

    if (_barcode == null) {
      return Row(
        children: [
          const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Scanning…",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.verified, color: Colors.greenAccent),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            _barcode?.displayValue ?? "No display value",
            style: const TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        TextButton(onPressed: _resetScan, child: const Text("Scan again")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      
      body: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) => _handleBarcode(capture, context),
            ),
          ),

          // Dark overlay + scan window
          const Positioned.fill(child: _ScannerOverlay()),

          // Top bar
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).padding.top + 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    color: Colors.black.withOpacity(0.35),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Scan QR Code",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Torch
                        ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, state, child) {
                            final isOn = state == TorchState.on;
                            return IconButton(
                              onPressed: () => controller.toggleTorch(),
                              icon: Icon(
                                isOn ? Icons.flash_on : Icons.flash_off,
                                color: isOn ? Colors.amber : Colors.white,
                              ),
                            );
                          },
                        ),
                        // Switch camera
                        IconButton(
                          onPressed: () => controller.switchCamera(),
                          icon: const Icon(
                            Icons.cameraswitch,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Center hint animation (only when not started)
          if (!isStart)
            Center(
              child: Opacity(
                opacity: 0.55,
                child: Lottie.asset(
                  'assets/lottie/qrcode.json',
                  
                  height: 160,
                  width: 160,
                  
                ),
              ),
            ),

          // Bottom panel
          Positioned(
            left: 16,
            right: 16,
            bottom: 16 + bottomSafe,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  color: Colors.black.withOpacity(0.40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _statusWidget(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: CustomWidgets.customButton(
                              buttonName: isStart ? "Restart" : "Start",
                              height: 48,
                              context: context,
                              onPressed: () async {
                                _resetScan();
                                await controller.start();
                                setState(() => isStart = true);
                              },
                              btnColor: MyColors.primaryColor,
                              fontColor: MyColors.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomWidgets.customButton(
                              buttonName: "Stop",
                              height: 48,
                              context: context,
                              onPressed: () async {
                                await controller.stop();
                                setState(() => isStart = false);
                              },
                              btnColor: Colors.white.withOpacity(0.12),
                              fontColor: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Overlay with a transparent scan window + border
class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _ScannerOverlayPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()..color = Colors.white;

    // scan window size (responsive)
    final windowWidth = size.width * 0.72;
    final windowHeight = windowWidth; // square
    final left = (size.width - windowWidth) / 2;
    final top = (size.height - windowHeight) / 2.2;

    final windowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, windowWidth, windowHeight),
      const Radius.circular(18),
    );

    // Draw dark overlay
    final full = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutout = Path()..addRRect(windowRect);
    final overlayPath = Path.combine(PathOperation.difference, full, cutout);
    canvas.drawPath(overlayPath, overlayPaint);

    // Border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white.withOpacity(0.85);

    canvas.drawRRect(windowRect, borderPaint);

    // Corner accents
    final accentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..color = Colors.greenAccent.withOpacity(0.9);

    const corner = 22.0;

    // top-left
    canvas.drawLine(Offset(left, top + corner), Offset(left, top), accentPaint);
    canvas.drawLine(Offset(left, top), Offset(left + corner, top), accentPaint);

    // top-right
    canvas.drawLine(
      Offset(left + windowWidth - corner, top),
      Offset(left + windowWidth, top),
      accentPaint,
    );
    canvas.drawLine(
      Offset(left + windowWidth, top),
      Offset(left + windowWidth, top + corner),
      accentPaint,
    );

    // bottom-left
    canvas.drawLine(
      Offset(left, top + windowHeight - corner),
      Offset(left, top + windowHeight),
      accentPaint,
    );
    canvas.drawLine(
      Offset(left, top + windowHeight),
      Offset(left + corner, top + windowHeight),
      accentPaint,
    );

    // bottom-right
    canvas.drawLine(
      Offset(left + windowWidth - corner, top + windowHeight),
      Offset(left + windowWidth, top + windowHeight),
      accentPaint,
    );
    canvas.drawLine(
      Offset(left + windowWidth, top + windowHeight - corner),
      Offset(left + windowWidth, top + windowHeight),
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
