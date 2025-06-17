import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_attendance_project/screen/qr/qr_scanner/components/un_successfull_scan_screen.dart';
import 'components/qr_scanner_animation_overlay.dart';
import '../../../export.dart';

class QrScannerScreen extends StatefulWidget {
  final LessonModel lessonModel;
  final StudentModel studentModel;
  final Position? position;

  const QrScannerScreen({
    super.key,
    required this.lessonModel,
    required this.studentModel, this.position,
  });

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen>
    with NavigatorManager, WidgetsBindingObserver {
  late final QrScannerView _vm;
  MobileScannerController? _scannerController;
  final DateTime now = DateTime.now();
  StreamSubscription<BarcodeCapture>? _subscription;


  @override
  void initState() {
    super.initState();
    _vm = QrScannerView();
    WidgetsBinding.instance.addObserver(this);
   _vm.setLocationData(widget.position);
    _initializeScanner();
  }

  void _initializeScanner() {
    _scannerController = MobileScannerController(
      autoStart: false,
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 1500,
    );
    _vm.checkAndStartCamera(_scannerController!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_scannerController == null || !_scannerController!.value.isInitialized)
      return;

    if (state == AppLifecycleState.resumed) {
      debugPrint("App resumed → starting camera");
      _scannerController!.start();
    } else if (state == AppLifecycleState.paused) {
      debugPrint("App paused → stopping camera");
      _scannerController!.stop();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scannerController?.stop();
    _scannerController?.dispose();
    _scannerController = null;
    super.dispose();
  }

  Future<void> _handleBarcodeDetection(BarcodeCapture barcodeCapture) async {
    if (!_vm.isScanner.value) return;

    final barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue == null) return;

    final String code = barcode.rawValue!;
    final bool isMatch =
        _vm.isLessonCodeMatch(code, widget.lessonModel.lessonCode!);
    final bool? isDistance = await _vm.isWithinRangeFromQr(
      code: code,
      limitInMeters: 100,
    );
    //Hata firlatiyor
    if (isMatch && (isDistance ?? false)) {
      final String? codeContent = await _vm.addScannedDataToFireStore(
        data: code,
        mobileScannerController: _scannerController!,
      );

      String positionString =
          '${_vm.currentLocation.value?.latitude.toStringAsFixed(6)}-${_vm.currentLocation.value?.longitude.toStringAsFixed(6)}';

      final isSuccess = await _vm.takeAttendance(
        lessonClass: widget.lessonModel.classLevel!,
        attendanceModel: AttendanceModel(
          studentId: widget.studentModel.studentId,
          schoolNumber: widget.studentModel.schoolNumber,
          studentName: widget.studentModel.studentName,
          studentSurname: widget.studentModel.studentSurname,
          attendanceLessonId: widget.lessonModel.lessonId,
          qrAttendanceClass: int.parse(widget.lessonModel.classLevel!),
          qrAttendanceId: codeContent,
          qrCodeData: codeContent,
          createdDate: Timestamp.fromDate(now),
          qrCodeLocation: positionString,
        ),
      );

      // Optionally, show success message or navigate
      navigateToWidget(
        context,
        SuccessfulScanScreen(
          qrCodeData: codeContent,
          lessonModel: widget.lessonModel,
          studentModel: widget.studentModel,
          isSuccess: isSuccess,
        ),
      );
    } else {
      navigateToWidget(
        context,
        UnSuccessfullScanScreen(
          errorMessage:
              LocaleKeys.studentLessonDetail_unsuccessfulAttendance.locale,
          lessonModel: widget.lessonModel,
          studentModel: widget.studentModel,
          lessonName: widget.lessonModel.lessonName!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _vm.hasPermission,
        builder: (_, __, ___) {
          return _vm.hasPermission.value
              ? ValueListenableBuilder(
                  valueListenable: _vm.isScanner,
                  builder: (_, __, ___) {
                    return Stack(
                      children: [
                        MobileScanner(
                          controller: _scannerController,
                          onDetect: (barcodeCapture) async {
                            _handleBarcodeDetection(barcodeCapture);
                          },
                        ),
                        Center(
                          child: CustomQrScannerOverlay(
                            isScanning: _vm.isScanner.value,
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Padding(
                  padding: WidgetSizes.normalPadding.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCardWidget(
                        paddingValue: 20,
                        childWidget: permissionWidgets(),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget permissionWidgets() {
    return Column(
      children: [
        Icon(
          Icons.camera_alt_outlined,
          size: 64,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(LocaleKeys.studentLessonDetail_cameraPermission.locale,
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        CustomButton(
          onPress: () => _vm.checkPermission(),
          title: LocaleKeys.studentLessonDetail_grandPermission.locale,
        ),
      ],
    );
  }
}
