import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:securepay/widgets.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  // Initialize without auto-starting to prevent early channel calls
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    // WayDroid often only sees one camera, so don't force 'back'
    facing: CameraFacing.front,
    detectionSpeed: DetectionSpeed.normal,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Start the controller manually after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.start();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Professional Tip: Stop camera when app is in background to save battery
    // and prevent channel exceptions
    if (!controller.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        controller.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        controller.stop();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 2. Live Camera Feed
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
                // Handle the scan result (e.g., navigate to Send Payment)
                _handleScanResult(barcode.rawValue);
              }
            },
          ),

          // 3. Custom Glassmorphism Overlay
          const ScannerOverlay(),

          // 4. Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 5. Upload from Gallery Button (Glass Effect)
          Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: GalleryUploadButton(
              onTap: () {
                // logic to pick image from gallery
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleScanResult(String? code) {
    if (code != null) {
      // Logic: context.push('/send-payment?id=$code');
      controller.stop(); // Stop camera once detected
    }
  }
}
