import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attendance_project/screen/qr/qr_scanner/components/un_successfull_scan_screen.dart';
import 'components/qr_scanner_animation_overlay.dart';
import '../../../export.dart';

class QrScannerScreen extends StatefulWidget {
  final LessonModel lessonModel;
  final StudentModel studentModel;
  const QrScannerScreen({
    super.key,
    required this.lessonModel,
    required this.studentModel,
  });

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen>
    with NavigatorManager, WidgetsBindingObserver {
  late final QrScannerView _vm;
  late final MobileScannerController _scannerController;
  final DateTime now = DateTime.now();
  StreamSubscription<BarcodeCapture>? _subscription;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_scannerController.value.isInitialized) return;

    if (state == AppLifecycleState.resumed) {
      debugPrint("App resumed → trying to start camera");
      _scannerController.start();
    } else if (state == AppLifecycleState.paused) {
      debugPrint("App paused → stopping camera");
      _scannerController.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _vm = QrScannerView();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 1500,
    );
    _vm.checkAndStartCamera(_scannerController);
  }

  @override
  void dispose() {
    // Lifecycle observer'ı kaldır
    WidgetsBinding.instance.removeObserver(this);
    // Scanner controller'ı senkron biçimde dispose et
    _scannerController.stop();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            if (!_vm.isScanner.value) return;
                            final barcode = barcodeCapture.barcodes.first;
                            if (barcode.rawValue != null) {
                              final String code = barcode.rawValue!;
                              final bool isMatch = _vm.isLessonCodeMatch(
                                  code.toString(),
                                  widget.lessonModel.lessonCode!);
                              if (isMatch) {
                                final String? codeContent =
                                    await _vm.addScannedDataToFireStore(
                                  data: code,
                                  mobileScannerController: _scannerController,
                                );
                                final isSuccess = await _vm.takeAttendance(
                                  lessonClass: widget.lessonModel.classLevel!,
                                  attendanceModel: AttendanceModel(
                                    studentId: widget.studentModel.studentId,
                                    schoolNumber:
                                        widget.studentModel.schoolNumber,
                                    studentName:
                                        widget.studentModel.studentName,
                                    studentSurname:
                                        widget.studentModel.studentSurname,
                                    attendanceLessonId:
                                        widget.lessonModel.lessonId,
                                    qrAttendanceClass: int.parse(
                                        widget.lessonModel.classLevel!),
                                    qrAttendanceId: codeContent,
                                    qrCodeData: codeContent,
                                    createdDate: Timestamp.fromDate(now),
                                  ),
                                );
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
                                    errorMessage: LocaleKeys
                                        .studentLessonDetail_unsuccessfulAttendance
                                        .locale,
                                    lessonModel: widget.lessonModel,
                                    studentModel: widget.studentModel,
                                    lessonName: widget.lessonModel.lessonName!,
                                  ),
                                );
                              }
                            }
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
