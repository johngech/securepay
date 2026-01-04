import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:securepay/payments/widgets.dart';

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

  // Safe Start method to catch WayDroid/Emulator hardware errors
  Future<void> _startScanner() async {
    try {
      await controller.start();
    } catch (e) {
      debugPrint("Scanner failed to start: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Camera not available on this device.")),
        );
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Professional Tip: Stop camera when app is in background to save battery
    // and prevent channel exceptions
    if (!controller.value.isInitialized) return;

    if (state case AppLifecycleState.resumed) {
      _startScanner();
    } else {
      controller.stop();
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
              _handleScanResult(capture);
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
            child: GalleryUploadButton(onTap: () => _pickImageFromGallery()),
          ),
        ],
      ),
    );
  }

  void _handleScanResult(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        debugPrint('QR Scanned Successfully: $code');
        // Stop the camera once we have a result
        controller.stop();
        //  Navigate to SendPaymentScreen with 'code'
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    // 1. Pick the image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    try {
      // 2. Analyze the image.
      // In the latest mobile_scanner, this returns a BarcodeCapture?
      final BarcodeCapture? capture = await controller.analyzeImage(image.path);

      // 3. Handle the result manually since analyzeImage
      // sometimes doesn't fire the onDetect callback automatically
      if (capture != null && capture.barcodes.isNotEmpty) {
        _handleScanResult(capture);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No QR code found in this image.')),
          );
        }
      }
    } catch (e) {
      debugPrint("Gallery analysis error: $e");
    }
  }
}
