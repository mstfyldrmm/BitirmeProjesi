import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_project/services/attendance_service/attendance_service.dart';
import '../../../export.dart';

class QrGeneratorView extends ChangeNotifier {
  ValueNotifier<int> tabCurrentIndex = ValueNotifier(0);
  ValueNotifier<int> timerLimit = ValueNotifier(0);
  ValueNotifier<bool> isCreatedQr = ValueNotifier(false);
  ValueNotifier<String> qrData = ValueNotifier('');
  ValueNotifier<int> remainingTime = ValueNotifier(0);
  ValueNotifier<bool> isSelect = ValueNotifier(false);

  void selectText() {
    isSelect.value = !isSelect.value;
  }

  void selectTabItem(int index) {
    if (index == 0) {
      tabCurrentIndex.value = 0;
    } else if (index == 1) {
      selectText();
      tabCurrentIndex.value = 1;
    } else if (index == 2) {
      selectText();
      tabCurrentIndex.value = 2;
    }
  }

  bool isTimerLimitValid(String limitType, int limitValue) {
    return switch (limitType) {
      'Second' => limitValue >= 30,
      'Minute' || 'Hour' => limitValue >= 1,
      _ => false
    };
  }

  String timerLimitType() {
    return switch (tabCurrentIndex.value) {
      0 => 'Second',
      1 => 'Minute',
      2 => 'Hour',
      _ => 'Second'
    };
  }

  Future<bool> startAttendance({required LessonModel lessonModel}) async {
    final limitType = timerLimitType();

    bool isValidLimit = isTimerLimitValid(limitType, timerLimit.value);

    if (isValidLimit) {
      final now = DateTime.now();
      final qrData = createQrData(
        lessonCode: "${lessonModel.lessonCode}",
        createDateTime: now,
      );
      isCreatedQr.value = true;

      startTimer(
        lessonModel: lessonModel,
      );
      await AttendanceService().attendanceStart(
        lessonClass: lessonModel.classLevel ?? '1',
        qrAttendanceModel: QrAttendanceModel(
          attendanceLessonId: lessonModel.lessonId,
          createdDate: Timestamp.fromDate(now),
          qrAttendanceClass: 1,
          qrAttendanceId: qrData,
          qrCodeData: qrData,
          qrCodeTimeLimit: timerLimit.value,
          qrCodeTimeLimitType: timerLimitType(),
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteAttendance({required String attendanceId}) async {
    isCreatedQr.value = false;
    stopTimer();
    await AttendanceService().attendanceFinished(
      lessonClass: '1',
      attendanceId: attendanceId,
    );
  }

  String createQrData({
    required String lessonCode,
    required DateTime createDateTime,
  }) {
    final String createdDay = DateFormat('dd-MM-yyyy').format(createDateTime);
    final String createdTime = DateFormat('HH:mm:ss').format(createDateTime);
    final String microsecondData =
        createDateTime.microsecondsSinceEpoch.toString();
    final String data = "$lessonCode-$createdDay-$createdTime-$microsecondData";
    qrData.value = data;
    return data;
  }

  int _calculateTotalSeconds() {
    switch (tabCurrentIndex.value) {
      case 0:
        return timerLimit.value;
      case 1:
        return timerLimit.value * 60;
      case 2:
        return timerLimit.value * 3600;
      default:
        return timerLimit.value;
    }
  }

  Timer? timer;

  void startTimer({
    required LessonModel lessonModel,
  }) {
    remainingTime.value = _calculateTotalSeconds();
    if (timer != null && timer!.isActive) return;
    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        Future.wait([
          deleteAttendance(attendanceId: qrData.value),
          startAttendance(lessonModel: lessonModel),
        ]);
        remainingTime.value = _calculateTotalSeconds();
      }
    });
  }

  void resetTimer() => timerLimit.value;

  void stopTimer({bool reset = false}) {
    timer?.cancel();
    remainingTime.value = 0;
    if (reset) {
      resetTimer();
    }
  }
}
