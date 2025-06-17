import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../export.dart';

class QrScannerView extends ChangeNotifier {
  ValueNotifier<bool> hasPermission = ValueNotifier(false);
  ValueNotifier<bool> isFlashOn = ValueNotifier(false);
  ValueNotifier<bool> isScanner = ValueNotifier(true);
  ValueNotifier<Position?> currentLocation = ValueNotifier(null);

  final _logger = Logger(printer: PrettyPrinter());

  Future<bool> checkPermission() async {
    final status = await Permission.camera.request();
    hasPermission.value = status.isGranted;
    return hasPermission.value;
  }

  Future<void> checkAndStartCamera(MobileScannerController controller) async {
    final status = await Permission.camera.request();
    hasPermission.value = status.isGranted;

    if (hasPermission.value) {
      await controller.start();
      _logger.i("Kamera izni verildi ve baslatildi");
    } else {
      debugPrint("Kamera izni verilmedi.");
    }
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

  void setLocationData(Position? data) {
    currentLocation.value = data;
  }

  Future<bool?> isWithinRangeFromQr({
    required String code,
    double limitInMeters = 100,
  }) async {
    try {
      // QR'ı parçalara ayır
      List<String> parts = code.split('-');
      if (parts.length < 7) return null; // Hatalı QR yapısı

      // Son iki parçayı al
      double targetLat = double.parse(parts[parts.length - 2]);
      double targetLng = double.parse(parts[parts.length - 1]);

      // Şu anki konumu al
      
      if (currentLocation.value == null) return null;

      // Mesafeyi hesapla
      double distanceInMeters = Geolocator.distanceBetween(
        currentLocation.value!.latitude,
        currentLocation.value!.longitude,
        targetLat,
        targetLng,
      );

      debugPrint('QR Mesafe: $distanceInMeters metre');

      return distanceInMeters <= limitInMeters;
    } catch (e) {
      debugPrint('Hata oluştu: $e');
      return null;
    }
  }

  /// Hedef konuma olan uzaklığı metre cinsinden döner.
  /// [targetLat] ve [targetLng] hedef konum koordinatlarıdır.
  Future<double?> getDistanceToTarget(
    double targetLat,
    double targetLng,
  ) async {

    if (currentLocation.value == null) return null;

    double distanceInMeters = Geolocator.distanceBetween(
      currentLocation.value !.latitude,
      currentLocation.value !.longitude,
      targetLat,
      targetLng,
    );

    return distanceInMeters;
  }
}
