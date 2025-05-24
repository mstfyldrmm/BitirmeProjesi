import 'package:permission_handler/permission_handler.dart';
import '../../../export.dart';

class QrScannerView extends ChangeNotifier {
  ValueNotifier<bool> hasPermission = ValueNotifier(false);
  ValueNotifier<bool> isFlashOn = ValueNotifier(false);
  ValueNotifier<bool> isScanner = ValueNotifier(true);

  final _logger = Logger(printer: PrettyPrinter());

  Future<void> checkPermission() async {
    final status = await Permission.camera.request();
    hasPermission.value = status.isGranted;
  }

  Future<String?> addScannedDataToFireStore({
    required String? data,
    required MobileScannerController mobileScannerController,
  }) async {
    try {
      if (data == null) return null;
      isScanner.value = false;
      await mobileScannerController.stop();
      _logger.i(data.toString());
      return data.toString();
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }

  Future<bool> takeAttendance({
    required AttendanceModel attendanceModel,
    required String lessonClass,
  }) async {
    return await AttendanceService().takeClassAttendance(
      lessonClass: lessonClass,
      attendanceModel: attendanceModel,
    );
  }

  bool isLessonCodeMatch(String input, String lessonCode) {
    final prefix = input.split('-').first;
    return prefix == lessonCode;
  }
}
